From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit
	 archs
Date: Wed, 01 Jul 2009 08:00:26 +0100
Message-ID: <4A4B25AA020000780000861D@vpn.id2.novell.com>
References: <4A4A18780200007800008345@vpn.id2.novell.com>
 <200907011430.29524.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753287AbZGAHAf@vger.kernel.org>
In-Reply-To: <200907011430.29524.rusty@rustcorp.com.au>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, tony.luck@intel.com, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

>>> Rusty Russell <rusty@rustcorp.com.au> 01.07.09 07:00 >>>
>On Tue, 30 Jun 2009 09:21:52 pm Jan Beulich wrote:
>> Since these CRCs are really only 32-bit quantities, there's no need to
>> store them in 64-bit slots. Since, however, gcc doesn't allow
>> respective initializations, asm() constructs get used to create the CRC
>> tables (and its for that reason that the patch only makes x86-64 and
>> ia64 utilize that functionality, as I can't verify this doesn't break
>> in some subtle way elsewhere).
>
>Hmm, can we change the build system to just link this in as a normal table, 
>rather than use linker tricks?
>
>Then genksyms would just spit out a C file we could compile and link into final 
>vmlinux.

That's going to be non-trivial, because of the ordering that's required to be
identical between the symbol and the CRC tables. Basically that would mean
that genksyms would need to look at either the assembly output or the
object file, which would further slow down the build process. Compared to
that the asm() solution in the patch sent seems more strait forward (despite
it possibly looking convoluted at the first glance).

Jan
