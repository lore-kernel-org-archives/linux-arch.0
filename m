Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Feb 2005 14:50:37 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Fix shmget for ppc64, s390-64 & sparc64.
Message-Id: <20050209145037.4bc3ea33.akpm@osdl.org>
In-Reply-To: <20050209134342.GA5716@mschwid3.boeblingen.de.ibm.com>
References: <20050209134342.GA5716@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: anton@samba.org, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> Hi folks,
> the patch for the shmget > 2GB problem. Please review,
> Dave, Anton?
> 
> blue skies,
>   Martin.
> 
> ---
> 
> [patch] Fix shmget for ppc64, s390-64 & sparc64.

OK, but Andi's patch fixed mips and x86_64 as well, but only for
compat_shmget and not for sys_msgsnd and sys_msgrcv.
