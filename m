From: Jessica Yu <jeyu@redhat.com>
Subject: Re: module.h: remove extable.h include now users have migrated
Date: Thu, 9 Feb 2017 00:34:53 -0500
Message-ID: <20170209053453.GB25776@packer-debian-8-amd64.digitalocean.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
 <20170122163244.11740-21-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbdBIFmu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Feb 2017 00:42:50 -0500
Content-Disposition: inline
In-Reply-To: <20170122163244.11740-21-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

+++ Paul Gortmaker [22/01/17 11:32 -0500]:
>With hopefully most/all users of module.h that were looking for
>exception table functions moved over to the new extable.h header,
>we can remove the back-compat include that let us transition
>without introducing build regressions.
>
>Cc: Rusty Russell <rusty@rustcorp.com.au>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Jessica Yu <jeyu@redhat.com>
