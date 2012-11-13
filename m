From: David Howells <dhowells@redhat.com>
Subject: Re: [GIT PULL] UAPI: perf fixes
Date: Tue, 13 Nov 2012 11:11:05 +0000
Message-ID: <14071.1352805065@warthog.procyon.org.uk>
References: <CA+5PVA5vMyNmQYCLX315Jc+kN9zQuZo_h0Devpjfr43TezE-qA@mail.gmail.com> <1378.1352379110@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63596 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752862Ab2KMLLj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Nov 2012 06:11:39 -0500
In-Reply-To: <CA+5PVA5vMyNmQYCLX315Jc+kN9zQuZo_h0Devpjfr43TezE-qA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Boyer <jwboyer@gmail.com>
Cc: dhowells@redhat.com, acme@ghostprotocols.net, mingo@kernel.org, tglx@linutronix.de, bp@alien8.de, namhyung@gmail.com, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

Josh Boyer <jwboyer@gmail.com> wrote:

> This patch seems to break building perf on ppc64.  It fails with:

Hmmm...  Getting my hands on an ARM or ppc/ppc64 box running Fedora is a
problem, and as far as I know, this needs to be built natively or maybe
cross-compiled with a full environment (including graphics libs).

David
