Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032048Ab2CORmE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Mar 2012 13:42:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <553CFBBAF1315044BC4CD328C97B0B1C17FA0A76@DNCE02.ent.ti.com>
References: <553CFBBAF1315044BC4CD328C97B0B1C17FA0A76@DNCE02.ent.ti.com> <20120312233602.13888.27659.stgit@warthog.procyon.org.uk> <20120312233706.13888.5678.stgit@warthog.procyon.org.uk> <1331728169.2167.2.camel@deneb.redhat.com>
Subject: Re: [Linux-c6x-dev] [PATCH 06/35] Disintegrate asm/system.h for C6X [ver #2]
Date: Thu, 15 Mar 2012 17:41:55 +0000
Message-ID: <20883.1331833315@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Jacquiot, Aurelien" <a-jacquiot@ti.com>
Cc: dhowells@redhat.com, Mark Salter <msalter@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "hpa@zytor.com" <hpa@zytor.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Message-ID: <20120315174155.3GFV71RDqRONb4pYvc7iFEK1O_s_a-4AaJZkJ1paQkQ@z>

Jacquiot, Aurelien <a-jacquiot@ti.com> wrote:

> Are you sure about the #define _ASM_C6X_BARRIER_H in exec.h? _ASM_C6X_EXEC_H
> sounds better...

Yep.

David
