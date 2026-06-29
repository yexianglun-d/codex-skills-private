# 10 Ownership Locks

记录当前活跃线程的文件/目录写入权。这里不是操作系统强制锁；`claim_ownership.sh` / `release_ownership.sh` 会用 `docs/project-memory/.locks/ownership.lock.d` 原子目录锁保护脚本内的检查-写入过程。

| Lock ID | Task ID | Owner/Thread | Branch/Worktree | Owned Path | Mode | Status | Started At | Expires/Review At | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |

## 状态

- `ACTIVE`：当前线程拥有该路径写入权。
- `RELEASED`：任务结束或集成完成，写入权已释放。
- `BLOCKED`：任务阻塞，保留 ownership，防止别人误改。
- `STALE`：疑似过期，需要主线程确认后释放或续期。

## 规则

- 同一 `Owned Path` 不能同时有两个 `ACTIVE` 写锁。
- 父子路径视为冲突，例如 `src` 与 `src/auth`。
- `write` 与 `integration` 互斥；`integration` 与 `write/review/integration` 互斥。
- `Mode` 只允许 `read`、`write`、`review`、`integration`。
- `Owned Path` 必须是仓库相对路径，禁止绝对路径和任何 `..` path component。
- 共享核心文件优先拆成集成任务；不要让多个 worker 同时写。
- worker 越界修改必须在 inbox 上报中说明原因和证据。
