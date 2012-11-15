From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/2] perf kvm: fix building perf kvm on PowerPC
Date: Thu, 15 Nov 2012 10:46:54 +0000
Message-ID: <6764.1352976414@warthog.procyon.org.uk>
References: <50A48912.20606@linux.vnet.ibm.com> <1378.1352379110@warthog.procyon.org.uk> <CA+5PVA5vMyNmQYCLX315Jc+kN9zQuZo_h0Devpjfr43TezE-qA@mail.gmail.com> <18065.1352820271@warthog.procyon.org.uk> <CA+5PVA6qaxCzr8RBV616D3kEXyj9XjS3okeZXhJJL1R4+-Yv_A@mail.gmail.com> <20121113163458.GA1023@ghostprotocols.net> <50A488DD.6090106@linux.vnet.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63549 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992442Ab2KOKrW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Nov 2012 05:47:22 -0500
In-Reply-To: <50A48912.20606@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
Cc: dhowells@redhat.com, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Josh Boyer <jwboyer@gmail.com>, mingo@kernel.org, haodong@linux.vnet.ibm.com, runzhen@linux.vnet.ibm.com, dsahern@gmail.com, tglx@linutronix.de, bp@alien8.de, namhyung@gmail.com, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com> wrote:

> Now, 'perf kvm stat' is only supported on x86, let its code depend
> on ARCH_X86 to fix building it on other architectures

Other parts of perf do this sort of thing:

	#if defined(__x86_64__) || defined(__i386__)

David
