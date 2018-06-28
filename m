Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36041 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeF1GSD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Jun 2018 02:18:03 -0400
Date: Thu, 28 Jun 2018 08:17:59 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: untag user pointers passed to the kernel
Message-ID: <20180628061758.j6bytsaj5jk4aocg@ltop.local>
References: <cover.1529507994.git.andreyknvl@google.com>
 <CAAeHK+zqtyGzd_CZ7qKZKU-uZjZ1Pkmod5h8zzbN0xCV26nSfg@mail.gmail.com>
 <20180626172900.ufclp2pfrhwkxjco@armageddon.cambridge.arm.com>
 <CAAeHK+yqWKTdTG+ymZ2-5XKiDANV+fmUjnQkRy-5tpgphuLJRA@mail.gmail.com>
 <0cef1643-a523-98e7-95e2-9ec595137642@arm.com>
 <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627171757.amucnh5znld45cpc@armageddon.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Mark Rutland <Mark.Rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Kostya Serebryany <kcc@google.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Chintan Pandya <cpandya@codeaurora.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Evgeniy Stepanov <eugenis@google.com>, Kees Cook <keescook@chromium.org>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Al Viro <viro@zeniv.linux.org.uk>nd <nd@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Memory Management List <linux-mm@kvack.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Lee Smith <Lee.Smith@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <Robin.Murphy@arm.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20180628061759.cngarqXg1Hq8hWA-_o1C10dZm7p16tvXELOAbZnPy0s@z>

On Wed, Jun 27, 2018 at 06:17:58PM +0100, Catalin Marinas wrote:
> 
> sparse is indeed an option. The current implementation doesn't warn on
> an explicit cast from (void __user *) to (unsigned long) since that's a
> valid thing in the kernel. I couldn't figure out if there's any other
> __attribute__ that could be used to warn of such conversion.

Hi,

sparse doesn't have such attribute but would an new option that would warn
on such cast be a solution for your case?

-- Luc
