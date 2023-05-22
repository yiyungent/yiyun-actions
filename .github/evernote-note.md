---
title: {{ note.title }}
date: {{ note.created | string.slice 0 4 }}-{{ note.created | string.slice 4 2 }}-{{ note.created | string.slice 6 2 }} {{ note.created | string.slice 9 2 }}:{{ note.created | string.slice 11 2 }}:{{ note.created | string.slice 13 2 }}
updated: {{ note.updated | string.slice 0 4 }}-{{ note.updated | string.slice 4 2 }}-{{ note.updated | string.slice 6 2 }} {{ note.updated | string.slice 9 2 }}:{{ note.updated | string.slice 11 2 }}:{{ note.updated | string.slice 13 2 }}
tags:
  {{ for item in note.tag }}
  - "{{ item }}"
  {{ end }}
  - "来自-印象笔记"
  - "印象笔记-{{ note.note_attributes.source }}"
categories:
  - "来自-印象笔记"
  {{ for item in cat_name_list }}
  - "{{ item }}"
  {{ end }}
description: {{ note.title }}
public: false
---

{{ md_file_content }}
