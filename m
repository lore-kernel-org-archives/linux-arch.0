Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] Consistently use the name asm-offsets.h
Date: Thu, 8 Sep 2005 14:39:04 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0456EE9E@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

The existing ia64 specific rule to generate offsets.h
has to "echo #define IA64_TASK_SIZE 0 > include/asm-ia64/offsets.h"
before building asm-offsets.s to avoid compilation errors.

So long as you take care of this somehow in the generic version, go wild.

-Tony
