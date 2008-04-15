From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: + kernel-add-common-infrastructure-for-unaligned-access.patch
	added to -mm tree
Date: Tue, 15 Apr 2008 10:24:32 -0700
Message-ID: <1208280272.11920.87.camel@brick>
References: <200804142214.m3EMET5L029431@imap1.linux-foundation.org>
	 <1208261668.9212.18.camel@pmac.infradead.org>
	 <1208272073.11920.74.camel@brick>
	 <1208275927.9212.58.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208275927.9212.58.camel-ZP4jZrcIevRpWr+L1FloEB2eb7JE58TQ@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2008-04-15 at 17:12 +0100, David Woodhouse wrote:
> On Tue, 2008-04-15 at 08:07 -0700, Harvey Harrison wrote:
> > The reason I kept the byte-shifting versions around was that for
> > arches that need special handling of unaligned access,
> 
> Are there any? GCC should emit appropriate code for the packed-structure
> version on all architectures, shouldn't it?
> 
> > they could do the byteshifting manually and get the unaligned access
> > 'for free' as it were. 
> 
> GCC really ought to be able to sort that out for itself. Let the dog see
> the rabbit.

Sorry, I didn't explain that very well, let me try again.  There is also
some new API along with this patch, for a reason:

This type of pattern, repeat for various byteorder/widths:
le32_to_cpu(get_unaligned((__le32 *)p))

For which the following has been added:
get_unaligned_le32(p)

Which allows BE arches that require special alignment handling to do
the endianness swapping as they do the unaligned accesses.  Similarly
for LE arches and the get_unaligned_be*

I realy think gcc will have a hard time seeing that it can fold the
accesses in this way.  If you grep for get/put_unaligned you'll
see the majority of the current users actually are wrapping it in
some kind of byteorder access as well...which prompted me to add
this api.

But _if_ gcc is smart enough to fold that together on arches with
special alignment requirements, I'm happy to move to a wrapper
approach.

HPA made the suggestion to look into this method, maybe he can 
explain it better than I.

Anyways, I hope I made myself a little clearer this time.

Harvey
