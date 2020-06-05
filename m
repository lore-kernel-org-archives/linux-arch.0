From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/2] MIPS: set page access bit with pgprot on some MIPS
 platform
Date: Fri, 5 Jun 2020 17:39:09 +0800
Message-ID: <20200605173909.000018ff@flygoat.com>
References: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1591348266-28392-1-git-send-email-maobibo@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Bibo Mao <maobibo@loongson.cn>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Andrew Morton <akpm@linux-foundation.org>, Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Fri,  5 Jun 2020 17:11:05 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> On MIPS system which has rixi hardware bit, page access bit is not
> set in pgrot. For memory reading, there will be one page fault to
> allocate physical page; however valid bit is not set, there will
> be the second fast tlb-miss fault handling to set valid/access bit.
> 
> This patch set page access/valid bit with pgrot if there is reading
> access privilege. It will reduce one tlb-miss handling for memory
> reading access.
> 
> The valid/access bit will be cleared in order to track memory
> accessing activity. If the page is accessed, tlb-miss fast handling
> will set valid/access bit, pte_sw_mkyoung is not necessary in slow
> page fault path. This patch removes pte_sw_mkyoung function which
> is defined as empty function except MIPS system.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---

Thanks for tracking it down.

Could you please make the patch tittle more clear?
"Some" looks confuse to me, "systems with RIXI" would be better.

- Jiaxun
