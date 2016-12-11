From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] mm: make pagoff_t type 64-bit
Date: Sun, 11 Dec 2016 15:59:01 +0100
Message-ID: <2636242.RWRJivuddj@wuerfel>
References: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com> <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: libc-alpha@sourceware.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Sunday, December 11, 2016 6:26:42 PM CET Yury Norov wrote:
> Also fix related interfaces
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  fs/btrfs/extent_io.c       | 2 +-
>  fs/ext2/dir.c              | 4 ++--
>  include/linux/mm.h         | 9 +++++----
>  include/linux/radix-tree.h | 8 ++++----
>  include/linux/types.h      | 2 +-
>  lib/radix-tree.c           | 8 ++++----
>  mm/debug.c                 | 2 +-
>  mm/internal.h              | 2 +-
>  mm/memory.c                | 4 ++--
>  mm/mmap.c                  | 7 ++++---
>  mm/readahead.c             | 4 ++--
>  mm/util.c                  | 3 ++-
>  12 files changed, 29 insertions(+), 26 deletions(-)
> 

Thanks Yury for the demonstration. I think this would put the nail
in the coffin of the idea of mmap64 even for Pavel, who didn't
seem convinced already.

Changing all those interfaces and structure, struct page in particular,
is clearly too costly for any advantage we might have otherwise
gained.

	Arnd
