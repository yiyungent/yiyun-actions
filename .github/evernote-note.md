---
title: {{ note.title }}
date: {{ date.parse note.created '%y%m%dT%H%M%SZ' | date.to_string '%F %T' }}
updated: {{ date.parse note.updated '%y%m%dT%H%M%SZ' | date.to_string '%F %T' }}
tags:
  {{ for item in note.tag }}
  - "{{ item }}"
  {{ end }}
categories:
  - ["来自-印象笔记"]
  - ["{{ note.note_attributes.source }}"]
description: {{ note.title }}
public: false
---

{{ md_file_content }}
