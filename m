Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751847AbdBAKBJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Feb 2017 05:01:09 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+55aFz8TFRykr0qNBjNbK+kavUdbGOm4huf5XhPLQcy0tMyLw@mail.gmail.com>
References: <CA+55aFz8TFRykr0qNBjNbK+kavUdbGOm4huf5XhPLQcy0tMyLw@mail.gmail.com> <20170131165537.GC23970@htj.duckdns.org> <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com> <17591.1485935811@warthog.procyon.org.uk> <CA+55aFyiy2jD80RTbsm3C=G5ifgtj8GQHqFwaYZM+ktgx1embA@mail.gmail.com> <CA+55aFxRLP_qPBXoLomxj-VYG-R=rKJE8KZ_h4NQ4g74gpNEWQ@mail.gmail.com>
Subject: Re: [GIT PULL] percpu fix for v4.10-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18627.1485943258.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date: Wed, 01 Feb 2017 10:00:58 +0000
Message-ID: <18628.1485943258@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Tejun Heo <tj@kernel.org>, dougmill@linux.vnet.ibm.com
Message-ID: <20170201100058._ck-WhpZUxXpO-avWlMGd5C11NKw06Xqk3bMxRIzXlg@z>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The return value isn't the value of the atomic variable.
> 
> The return value is whether the increment happened or not (ie the "was it not zero and
> could be incremented" part?)

Okay, fair enough.  I was thinking of it as atomic_long_inc_return() - which
obviously it isn't.

David
