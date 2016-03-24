From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Thu, 24 Mar 2016 15:28:15 -0700
Message-ID: <20160324152815.3489c6d54270f278e5dc7db4@linux-foundation.org>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
	<56F3A77D.6060802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42170 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbcCXW2Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Mar 2016 18:28:16 -0400
In-Reply-To: <56F3A77D.6060802@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, 24 Mar 2016 09:38:21 +0100 Denys Vlasenko <dvlasenk@redhat.com> wrote:

> On 03/24/2016 04:03 AM, Zhaoxiu Zeng wrote:
> > +/*
> > + * Type invariant interface to the compile time constant parity functions.
> > + */
> > +#define PARITY(w)    PARITY64((u64)w)
> 
> Can result in incorrect expansion of w. Should be PARITY64((u64)(w))

And we seem to be missing the other 30 patches.
