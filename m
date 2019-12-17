From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 20/22] arm64: mte: Allow user control of the excluded
 tags via prctl()
Date: Tue, 17 Dec 2019 17:56:11 +0000
Message-ID: <20191217175610.GN5624@arrakis.emea.arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-21-catalin.marinas@arm.com>
 <ef61bbc6-76d6-531d-2156-b57efc070da4@arm.com>
 <CAMn1gO6KGbeSkuEJB_j+WG8DAjbn81OdfA6DQQ+FFA5F6dcsVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAMn1gO6KGbeSkuEJB_j+WG8DAjbn81OdfA6DQQ+FFA5F6dcsVQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Collingbourne <pcc@google.com>
Cc: linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Branislav Rankov <Branislav.Rankov@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 16, 2019 at 09:30:36AM -0800, Peter Collingbourne wrote:
> On Mon, Dec 16, 2019 at 6:20 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> > In this patch, the default exclusion mask remains 0 (i.e. all tags can be generated).
> > After some more discussions, Branislav and I think that it would be better to start
> > with the reverse, i.e. all tags but 0 excluded (mask = 0xfe or 0xff).

So with mask 0xff, IRG generates only tag 0? This seems to be the case
reading the pseudocode in the ARM ARM.

> > This should simplify the MTE setup in the early C runtime quite a bit. Indeed, if all
> > tags can be generated, doing any heap or stack tagging before the
> > PR_SET_TAGGED_ADDR_CTRL prctl() is issued can cause problems, notably because tagged
> > addresses could end up being passed to syscalls. Conversely, if IRG and ADDG never
> > set the top byte by default, then tagging operations should be no-ops until the
> > prctl() is issued. This would be particularly useful given that it may not be
> > straightforward for the C runtime to issue the prctl() before doing anything else.
> >
> > Additionally, since the default tag checking mode is PR_MTE_TCF_NONE, it would make
> > perfect sense not to generate tags by default.
> >
> > Any thoughts?
> 
> This would indeed allow the early C runtime startup code to pass
> tagged addresses to syscalls, but I don't think it would entirely free
> the code from the burden of worrying about stack tagging. Either way,
> any stack frames that are active at the point when the prctl() is
> issued would need to be compiled without stack tagging, because
> otherwise those stack frames may use ADDG to rematerialize a stack
> object address, which may produce a different address post-prctl.
> Setting the exclude mask to 0xffff would at least make it more likely
> for this problem to be detected, though.
> 
> If we change the default in this way, maybe it would be worth
> considering flipping the meaning of the tag mask and have it be a mask
> of tags to allow. That would be consistent with the existing behaviour
> where userspace sets bits in tagged_addr_ctrl in order to enable
> tagging features.

Either option works for me. It's really for the libc people to decide
what they need. I think an "include" rather than "exclude" mask makes
sense with the default 0 meaning only generate tag 0.

Thanks.

-- 
Catalin
