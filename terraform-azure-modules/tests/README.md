# Tests

Terratest integration tests are not yet implemented for v0.1.

## Planned layout

- Go module at `tests/` with build tags.
- Each example under `examples/` will have a matching test that runs `terraform.InitAndApply` against a disposable subscription or test harness (organisation-specific).

## Running (future)

```bash
cd tests
go test -v -timeout 30m ./...
```

CI should set `ARM_*` environment variables for Azure authentication non-interactively.
