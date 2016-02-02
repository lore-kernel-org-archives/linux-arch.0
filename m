From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 06/12] s390: move exports to definitions
Date: Tue, 2 Feb 2016 12:29:31 +0100
Message-ID: <20160202112931.GD3990@osiris>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
 <1454095114-4128-6-git-send-email-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454095114-4128-6-git-send-email-viro@ZenIV.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 29, 2016 at 07:18:28PM +0000, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/s390/include/asm/Kbuild  |  1 +
>  arch/s390/kernel/Makefile     |  2 +-
>  arch/s390/kernel/entry.S      |  6 ++++++
>  arch/s390/kernel/mcount.S     |  3 +++
>  arch/s390/kernel/s390_ksyms.c | 15 ---------------
>  arch/s390/lib/mem.S           |  3 +++
>  6 files changed, 14 insertions(+), 16 deletions(-)
>  delete mode 100644 arch/s390/kernel/s390_ksyms.c

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>

