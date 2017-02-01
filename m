From: David Howells <dhowells@redhat.com>
Subject: Re: [GIT PULL] percpu fix for v4.10-rc6
Date: Wed, 01 Feb 2017 07:56:51 +0000
Message-ID: <17591.1485935811@warthog.procyon.org.uk>
References: <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com> <20170131165537.GC23970@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751080AbdBAH45 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Feb 2017 02:56:57 -0500
In-Reply-To: <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
Content-ID: <17590.1485935811.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Tejun Heo <tj@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dougmill@linux.vnet.ibm.com

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The fact is, atomic_long_inc_not_zero() shouldn't be returning
> anything with high bits..

Ummm...  Why's that the case?  If atomic_long_t can never exceed UINT_MAX,
then why does it exist at all?

David
