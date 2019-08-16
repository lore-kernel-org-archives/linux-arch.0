From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
Date: Fri, 16 Aug 2019 00:03:48 -0700
Message-ID: <20190816070348.GA13766@infradead.org>
References: <1565868537-17753-1-git-send-email-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565868537-17753-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, zhang_jian5@dahuatech.com, Guo Ren <ren_guo@c-sky.com>, Christoph Hellwig <hch@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 15, 2019 at 07:28:57PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> Implement the following apis to meet usage in different scenarios.
> 
>  - ioremap          (NonCache + StrongOrder)
>  - ioremap_nocache  (NonCache + StrongOrder)
>  - ioremap_wc       (NonCache + WeakOrder  )
>  - ioremap_cache    (   Cache + WeakOrder  )
> 
> Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.

Looks generally fine, but two comments:

 - do you have a need for ioremap_cache?  We are generally try to
   phase it out in favour of memremap, and it is generally only used
   by arch specific code.
 - I have a big series pending to clean up the mess with our
   ioremap_* functions, including adding a generic implementation
   that csky should be able to use.  Unless this patch is urgent it
   might make sense to rebase it on top.  Here is my current tree, I
   plan to post it soon:

	http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-ioremap
