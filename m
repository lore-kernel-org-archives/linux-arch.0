From: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Subject: Re: [microblaze-uclinux] Re: microblaze syscall list
Date: Fri, 25 Apr 2008 04:06:14 -0600
Message-ID: <20080425100614.GB14990@parisc-linux.org>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <200804221515.28075.arnd@arndb.de> <480FA729.3000406@seznam.cz> <200804241311.09881.arnd@arndb.de> <4810D4A4.7050900@seznam.cz> <4811A623.80104@itee.uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4811A623.80104-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: John Williams <jwilliams-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org>
Cc: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, git-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org

On Fri, Apr 25, 2008 at 07:36:35PM +1000, John Williams wrote:
> Please remember that MicroBlaze has been around as an arch for > 4 
> years, just not in the kernel.org tree.  These older style syscall 
> interfaces are all part of the uClibc and glibc ports for MicroBlaze.

So is it fair to say that you now understand this was the Wrong Way To
Do Things, and if anyone asks, you'd recommend getting an arch merged
into kernel.org sooner rather than later?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
