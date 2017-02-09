From: Jessica Yu <jeyu@redhat.com>
Subject: Re: core: migrate exception table users off module.h and onto
 extable.h
Date: Thu, 9 Feb 2017 00:33:49 -0500
Message-ID: <20170209053349.GA25776@packer-debian-8-amd64.digitalocean.com>
References: <20170122163244.11740-1-paul.gortmaker@windriver.com>
 <20170122163244.11740-20-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751179AbdBIFmc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Feb 2017 00:42:32 -0500
Content-Disposition: inline
In-Reply-To: <20170122163244.11740-20-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

+++ Paul Gortmaker [22/01/17 11:32 -0500]:
>These files were including module.h for exception table related
>functions.  We've now separated that content out into its own file
>"extable.h" so now move over to that and where possible, avoid all
>the extra header content in module.h that we don't really need to
>compile these non-modular files.
>
>Note:
>   init/main.c still needs module.h for __init_or_module
>   kernel/extable.c still needs module.h for is_module_text_address
>
>...and so we don't get the benefit of removing module.h from the cpp
>feed for these two files, unlike the almost universal 1:1 exchange
>of module.h for extable.h we were able to do in the arch dirs.
>
>Cc: Rusty Russell <rusty@rustcorp.com.au>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Linus Torvalds <torvalds@linux-foundation.org>
>Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

For the module.c bit:

Acked-by: Jessica Yu <jeyu@redhat.com>
