From: John Williams <jwilliams@itee.uq.edu.au>
Subject: Re: [microblaze-uclinux] Re: microblaze syscall list
Date: Sun, 27 Apr 2008 12:04:46 +1000
Message-ID: <4813DF3E.6080800@itee.uq.edu.au>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <200804221515.28075.arnd@arndb.de> <480FA729.3000406@seznam.cz> <200804241311.09881.arnd@arndb.de> <4810D4A4.7050900@seznam.cz> <4811A623.80104@itee.uq.edu.au> <20080425100614.GB14990@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758980AbYD0CG6@vger.kernel.org>
In-Reply-To: <20080425100614.GB14990@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: microblaze-uclinux@itee.uq.edu.au, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com
List-Id: linux-arch.vger.kernel.org

Matthew Wilcox wrote:
> On Fri, Apr 25, 2008 at 07:36:35PM +1000, John Williams wrote:
>> Please remember that MicroBlaze has been around as an arch for > 4 
>> years, just not in the kernel.org tree.  These older style syscall 
>> interfaces are all part of the uClibc and glibc ports for MicroBlaze.
> 
> So is it fair to say that you now understand this was the Wrong Way To
> Do Things, and if anyone asks, you'd recommend getting an arch merged
> into kernel.org sooner rather than later?
> 

Without question!  If some abject humility will smooth the path for 
MicroBlaze, I'm happy to show it.

By way of history, as a no-MMU arch starting on the 2.4 kernel series, 
there was no home for us in kernel.org originally, however we were 
always in the uClinux "mainline" at uclinux.org from the first release I 
did back in 2002.

We jumped in at 2.6.20 basing from some vendor patches that were never 
going to fly in kernel.org.  Since then we have been improving and 
cleaning them up to where they might actually stand a chance.

I am lobbying Xilinx (the effective "silicon vendor") as hard as I can 
to support both the push to and maintenance within kernel.org.  They had 
someone at ELC in Mountain View week before last, which is a good sign I 
think.

Cheers,

John
