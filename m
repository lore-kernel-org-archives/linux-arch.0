From: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] arch: switch the default on ARCH_HAS_SG_CHAIN
Date: Mon, 19 Nov 2018 16:48:02 -0800 (PST)
Message-ID: <mhng-bc691596-d40e-4dd5-b162-b767e550b92e@palmer-si-x1c4>
References: <20181119135852.GA16428@lst.de>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181119135852.GA16428-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Mon, 19 Nov 2018 05:58:52 PST (-0800), Christoph Hellwig wrote:
> On Fri, Nov 16, 2018 at 08:52:14AM -0800, Palmer Dabbelt wrote:
>> As far as I can tell, it looks like m68k, mips, and powerpc mention an
>> IOMMU in their ports, don't set ARCH_HAS_SG_CHAIN, and with this patch set
>> won't set ARCH_NO_SG_CHAIN.
>
> m68k has no iommu, and not operations that operate on a scatterlist.
>
> mips has a trivial iommu driver (jazzdma), but I wrote the current
> instance of it, nad it is fine.
>
> powerpc has various iommu, but actually enables ARCH_HAS_SG_CHAIN
> unconditionally.
>
>> The issue is that I'm not sure how to
>> determine what constitutes a horrible legacy IOMMU, at least with respect
>> to not being able to use scatterlist chaining.
>
> It basically means someone is iterating using manual pointer arithmetics
> over a multi-element scatterlist instead of using the sg_next and
> for_each_sg helpers.

Ah, OK.  In that case, feel free to drop a

Reviewed-by: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>

in there, if you think it helps any.

Thanks for the help!
