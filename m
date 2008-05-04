From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: microblaze syscall list
Date: Sun, 04 May 2008 15:53:07 -0700
Message-ID: <481E3E53.6050008@zytor.com>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <481D7DF7.3000909@seznam.cz> <481E3433.2030408@zytor.com> <200805050054.20903.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755196AbYEDXCz@vger.kernel.org>
In-Reply-To: <200805050054.20903.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: monstr@seznam.cz, microblaze-uclinux@itee.uq.edu.au, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann wrote:
> 
> * POSIX pselect does not update the timeout argument, but linux pselect7
> does, so it's easy to implement both pselect and select based on it.
> * pselect also has a timespec arguement, not timeval as select, but that's
> trivial to convert.
> * pselect obviously takes an extra argument, but if that's NULL, it will
> behave like select (aside from the timeout handling).
> 

Fair enough.

	-hpa
