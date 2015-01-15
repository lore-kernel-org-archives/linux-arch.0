From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/8] ppc/kvm: Replace ACCESS_ONCE with READ_ONCE
Date: Fri, 16 Jan 2015 10:09:29 +1100
Message-ID: <1421363369.23332.8.camel@ellerman.id.au>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
	 <1421312314-72330-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:49678 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899AbbAOXJd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Jan 2015 18:09:33 -0500
In-Reply-To: <1421312314-72330-2-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org

On Thu, 2015-01-15 at 09:58 +0100, Christian Borntraeger wrote:
> ACCESS_ONCE does not work reliably on non-scalar types. For
> example gcc 4.6 and 4.7 might remove the volatile tag for such
> accesses during the SRA (scalar replacement of aggregates) step
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
> 
> Change the ppc/kvm code to replace ACCESS_ONCE with READ_ONCE.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_rm_xics.c |  8 ++++----
>  arch/powerpc/kvm/book3s_xics.c       | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
> index 7b066f6..7c22997 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
> @@ -152,7 +152,7 @@ static void icp_rm_down_cppr(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
>  	 * in virtual mode.
>  	 */
>  	do {
> -		old_state = new_state = ACCESS_ONCE(icp->state);
> +		old_state = new_state = READ_ONCE(icp->state);

These are all icp->state.

Which is a union, but it's only the size of unsigned long. So in practice there
shouldn't be a bug here right?

cheers
