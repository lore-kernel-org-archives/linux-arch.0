Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47177 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbbIQJ5d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Sep 2015 05:57:33 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1442271047-4908-4-git-send-email-palmer@dabbelt.com>
References: <1442271047-4908-4-git-send-email-palmer@dabbelt.com> <1441832902-28993-1-git-send-email-palmer@dabbelt.com> <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
Subject: Re: [PATCH 03/13] Move COMPAT_ATM_ADDPARTY to net/atm/svc.c
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15267.1442483832.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Thu, 17 Sep 2015 10:57:12 +0100
Message-ID: <15268.1442483832@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dhowells@redhat.com, arnd@arndb.de, viro@zeniv.linux.org.uk, ast@plumgrid.com, aishchuk@linux.vnet.ibm.com, aarcange@redhat.com, akpm@linux-foundation.org, luto@kernel.org, acme@kernel.org, bhe@redhat.com, 3chas3@gmail.com, chris@zankel.net, dave@sr71.net, dyoung@redhat.com, drysdale@google.com, davem@davemloft.net, ebiederm@xmission.com, geoff@infradead.org, gregkh@linuxfoundation.org, hpa@zytor.com, mingo@kernel.org, iulia.manda21@gmail.com, plagnioj@jcrosoft.com, jikos@kernel.org, josh@joshtriplett.org, kexec@lists.infradead.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, mathieu.desnoyers@efficios.com, jcmvbkbc@gmail.com, paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl, tglx@linutronix.de, tomi.valkeinen@ti.com, vgoyal@redhat.com, x86@kernel.org
Message-ID: <20150917095712.kon0mbq5aO8gOU5xSioESqaM4mNsjBJciBeBFNJ_1NE@z>

Palmer Dabbelt <palmer@dabbelt.com> wrote:

> +#ifdef CONFIG_COMPAT
> +/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
> +#define COMPAT_ATM_ADDPARTY _IOW('a', ATMIOC_SPECIAL+4, struct compat_atm_iobuf)
> +#endif

I wonder if it would hurt to ditch the conditionals entirely.  It only eats
cpp namespace, not C namespace so it won't affect the output if it is not used
because the code that uses it is compiled out.

David
