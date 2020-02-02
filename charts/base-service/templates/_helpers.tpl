{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "base-service.name" -}}
{{- default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "base-service.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "base-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "base-service.appEnv" -}}
{{- if or .Values.config.envFromConfigMaps (or .Values.config.envFromSecrets .Values.vault.enabled) }}
envFrom:
{{- range .Values.config.envFromConfigMaps }}
- configMapRef:
    name: {{ . }}
{{- end }}
{{- range .Values.config.envFromSecrets }}
- secretRef:
    name: {{ . }}
{{- end }}
{{- if .Values.vault.enabled }}
- secretRef:
    name: {{ default .Release.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-vault
{{- end }}
{{- end }}
{{- if .Values.config.env }}
env:
{{- range $key, $value := .Values.config.env }}
  - name: {{ $key }}
    value: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end }}
