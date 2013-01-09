From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] Proposed removal of IS_ERR_OR_NULL() (was: Re: [PATCH
 1/4] gpiolib: introduce descriptor-based GPIO interface)
Date: Wed, 9 Jan 2013 15:21:03 +0000
Message-ID: <CACxGe6vXmJ5F4MC826BPSui1pckEzNa5-iaRSXa6TqHdp=UYzw@mail.gmail.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301081259.29839.arnd@arndb.de>
 <CAAVeFu+4VbCbj9TaeMm+NMDJ9_M4-j4O0ONF7Yh_un63wS38+Q@mail.gmail.com>
 <201301091035.23206.arnd@arndb.de>
 <20130109104414.GF3931@n2100.arm.linux.org.uk>
 <20130109111055.GG3931@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1301090932400.6300@xanadu.home>
 <20130109150427.GL3931@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130109150427.GL3931-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 9, 2013 at 3:04 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> So, it seems there's some concensus building here, and it seems that
> I've become the chosen victi^wvolunteer for this.  So, here's a patch.
> It's missing a Guns-supplied-by: tag though.
>
> From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Subject: Mark IS_ERR_OR_NULL() deprecated
>
> IS_ERR_OR_NULL() attracts a lot of abuse: people use it without much
> thought about it's effects.  Common errors include:
>  1. checking the returned pointer for functions defined as only
>     returning errno-pointer values, rather than using IS_ERR().
>     This leads to: ptr = foo(); if (IS_ERR_OR_NULL(ptr)) return
>      PTR_ERR(ptr);
>  2. using it to check functions which only ever return NULL on error,
>     thereby leading to another zero-error value return.
> In the case of debugfs functions, these return errno-pointer values when
> debugfs is configured out, which means code which blindly checks using
> IS_ERR_OR_NULL() ends up returning errors, which is rather perverse for
> something that's not implemented.
>
> Therefore, let's schedule it for removal in a few releases.
>
> Nicolas Pitre comments:
>> I do agree with Russell here.  Despite the original intentions behind
>> IS_ERR_OR_NULL() which were certainly legitimate, the end result in
>> practice is less reliable code with increased maintenance costs.
>> Unlike other convenience macros in the kernel, this one is giving a
>> false sense of correctness with too many people falling in the trap
>> of using it just because it is available.
>>
>> I strongly think this macro should simply be removed from the source
>> tree entirely and the code reverted to explicit tests against NULL
>> when appropriate.
>
> Suggested-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Tape-measuring-service-offered-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Victim-for-firing-sqad: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

I fully agree with doing this. While I'm not a fan of the PTR_ERR
pattern, this does (hopefully) make users think just a little bit more
about it.

> ---
> Ok, so I'm in the firing line for suggesting this, but it appears
> several people wish this to happen.
>
> I'm not intending to push this patch forwards _just_ yet: we need to
> sort out the existing users _first_ to prevent the kernel turning into
> one hell of a mess of warnings.

I currently see 355 users. That's a lot, but not inconceivable for an
auditing effort for pulling them out instead of scheduling for future
removal.

g.
