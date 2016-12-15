From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 15 Dec 2016 14:35:36 +0100
Message-ID: <f449ed0a-8142-121c-6af9-3fbdff1b517b@redhat.com>
References: <20161201051852.28dc335f@roar.ozlabs.ibm.com>
 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <20161201041325.GX35881@redhat.com>
 <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
 <20161201152039.GB35881@redhat.com>
 <20161209135041.5ff12770@roar.ozlabs.ibm.com>
 <0937c184-1946-c494-56b6-c38fd0b632c2@redhat.com>
 <20161209181459.1f0a4fed@roar.ozlabs.ibm.com>
 <249321c0-bcb1-f9d8-50f4-c083b656d02e@redhat.com>
 <20161210015653.5b0dc872@roar.ozlabs.ibm.com>
 <20161209160337.GA3061@kroah.com>
 <27aafb3b-adb2-47b8-7964-6e36fcb57676@redhat.com>
 <20161215120615.34fd0f22@roar.ozlabs.ibm.com>
 <a7e04d09-121c-df8c-9b4c-fedc7869c465@redhat.com>
 <20161215220322.63e72ff5@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161215220322.63e72ff5@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, Hannes Frederic Sowa <hannes@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


> Yeah it's great work, so is Stanislav's checker. I wouldn't mind having
> a kernel-centric checker tool merged in the kernel if it is small,
> maintained, and does a sufficient job for distros.

I'd be very happy to see the resulting tool in the kernel tree, as it 
needs to be kept in sync with any significant changes done to the kernel 
layout in the future.
It's not important if the result is based off libabigail or kabi-dw 
code, I'm sure both can be adjusted to serve the needs. kabi-dw tends to 
be smaller and still rather proof-of-concept, libabigail is definitely 
more mature. The only real difference is C vs. C++ code.

> So if I understand where we are, moving the ABI compatibility checking
> to one of these tools looks possible. What to do when we have an ABI change
> is not settled, but feeding version numbers explicitly into modversions
> is an option that would be close to what distros do today.

Sounds great!

Thank you!
-Stanislav
