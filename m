From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/16] mm: remove obsolete alloc_remap()
Date: Wed, 14 Mar 2018 15:56:16 +0100
Message-ID: <CAK8P3a1otS+2Q7qr0PE_VPXRp44kJqdZMhDFWuYK2g2jkNCCsA@mail.gmail.com>
References: <20180314143529.1456168-1-arnd@arndb.de> <20180314143958.1548568-1-arnd@arndb.de>
 <83b23320-e9de-a0cf-144c-1b60b9b7002a@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83b23320-e9de-a0cf-144c-1b60b9b7002a@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, Johannes Weiner <hannes@cmpxchg.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Petr Tesarik <ptesarik@suse.com>, Dave Hansen <dave.hansen@linux.intel.com>, Wei Yang <richard.weiyang@gmail.com>, Linux-MM <linux-mm@kvack.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 14, 2018 at 3:50 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> Hi Arnd,
>
> I like this cleanup, but arch/tile (which is afaik Orphaned but still in the gate) has:
>
> HAVE_ARCH_ALLOC_REMAP set to yes:
>
> arch/tile/Kconfig
>  config HAVE_ARCH_ALLOC_REMAP
>          def_bool y

It was a bit tricky to juggle the Cc lists here, but tile is removed
in patch 06/10
now. As I explained in the cover letter, it was originally planned to be marked
deprecated for a while first, but after some more discussion, nobody could come
up with a reason to keep it any longer. Same thing for mn10300,
blackfin and cris.

     Arnd
