# 企业级 Vue 目录结构

用于新项目、模块新增、目录治理或文件落位不明确时。已有项目如果已经形成稳定结构，先遵循现状；只有用户明确要求结构治理时，才按本规范迁移历史文件。

## 默认目录

适用于 Vue 3 + Vite + TypeScript 的中后台、业务系统、SaaS、管理端和复杂 H5 项目。

```text
src/
  api/                    # 按业务域拆分接口请求，不在组件里直接写请求细节
    request.ts            # 请求实例、拦截器、统一错误处理
    user.ts
    order.ts
  assets/                 # 参与构建的图片、字体、静态资源
  components/
    base/                 # 纯 UI 基础组件，不包含业务语义
    business/             # 跨页面复用的业务组件
    layout/               # 布局、导航、侧边栏、页头页脚
  composables/            # 跨页面复用的组合式逻辑
  constants/              # 业务常量、配置常量
  directives/             # 全局或可复用自定义指令
  enums/                  # 枚举或枚举型常量
  layouts/                # 页面布局壳，若项目已有 components/layout 可合并
  plugins/                # 第三方库初始化、全局插件注册
  router/
    guards/               # 登录、权限、埋点等路由守卫
    modules/              # 大型项目按业务域拆路由
    index.ts
  stores/
    modules/              # Pinia/Vuex 按业务域拆分
    index.ts
  styles/
    index.scss            # 全局样式入口
    variables.scss        # 变量或设计 token
    mixins.scss
  types/                  # 全局类型、接口返回类型、公共 DTO
  utils/                  # 无业务状态的纯工具函数
  views/                  # 路由级页面，按业务域分组
    user/
      index.vue
      detail.vue
      components/         # 仅 user 页面族内部使用的组件
      composables/        # 仅 user 页面族内部使用的组合逻辑
      constants.ts
      types.ts
  App.vue
  main.ts
```

## 放置规则

- 路由级页面放 `views/<domain>/`，不要放到通用 `components`。
- 只被一个页面族使用的组件放 `views/<domain>/components/`，不要提前提升为全局组件。
- 两个以上业务域复用且带业务含义的组件放 `components/business/`。
- 不带业务语义的按钮、弹窗、表格包装、空状态等基础组件放 `components/base/`。
- 请求函数放 `api/<domain>.ts`；请求实例、拦截器、鉴权头、统一错误处理放 `api/request.ts` 或项目已有等价文件。
- Pinia/Vuex 状态按业务域放 `stores/modules/`；局部 UI 状态优先留在组件或 composable，不上升到全局 store。
- 跨页面复用的组合式逻辑放 `composables/`；只服务某页面族的逻辑放 `views/<domain>/composables/`。
- 纯函数工具放 `utils/`；有业务语义的转换逻辑优先靠近业务域，不要塞进通用工具。
- 全局类型放 `types/`；页面私有类型放业务域内的 `types.ts`。
- 全局样式入口、变量、mixin 放 `styles/`；组件样式优先跟随组件。

## 命名建议

- 组件文件使用 PascalCase，例如 `UserPicker.vue`。
- 路由页面入口可使用 `index.vue`，同域子页面使用语义名，例如 `detail.vue`、`edit.vue`。
- composable 使用 `useXxx.ts`。
- store 使用 `useXxxStore.ts` 或项目已有 Pinia/Vuex 命名。
- API 文件按业务域命名，例如 `user.ts`、`order.ts`，不要命名为 `api1.ts`、`common2.ts`。

## 不同框架的调整

- Nuxt 项目优先遵循 Nuxt 约定目录，例如 `pages`、`components`、`composables`、`server`，不要强行改成 Vite 目录。
- uni-app 项目优先遵循 `pages.json`、`pages/`、`components/`、`static/`、`uni_modules/` 等多端约定。
- Vue 2 项目优先遵循已有 Vue CLI、Vuex、Options API 结构，不擅自引入 Vue 3 专属目录或写法。

## 禁止事项

- 不把所有文件都放进 `components`。
- 不把接口请求、权限判断、复杂业务流程直接写满页面组件。
- 不同时维护 `api` 和 `services` 两套含义重复的请求层，除非项目已有明确分工。
- 不为了一个页面新建全局 `modules`、`features`、`domain` 结构。
- 不因为目录规范移动大量历史文件而不处理 import、路由、测试和构建验证。
