Return-Path: <SRS0=SAVZ=A3=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:36068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGPV2h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 17:28:37 -0400
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 02/13] entry: Provide generic syscall exit function
In-Reply-To: <202007161354.62030182F@keescook>
References: <20200716182208.180916541@linutronix.de> <20200716185424.116500611@linutronix.de> <202007161354.62030182F@keescook>
Date: Thu, 16 Jul 2020 23:28:35 +0200
Message-ID: <87k0z3taik.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Message-ID: <20200716212835.Ms0os0bsKB6lhVPkTOCN2VXyYwV20ZPhhpoOZrf-dmM@z>

Kees Cook <keescook@chromium.org> writes:
> On Thu, Jul 16, 2020 at 08:22:10PM +0200, Thomas Gleixner wrote:
>
> This looks correct to me. Did you happen to run the seccomp selftests
> under this series?

Yes, I threw the relevant self tests on it.
