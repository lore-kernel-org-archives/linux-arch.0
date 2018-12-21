Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:58656 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389288AbeLUSob (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Dec 2018 13:44:31 -0500
From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] x86, kbuild: revert macrofying inline assembly code
References: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
Date: Fri, 21 Dec 2018 10:44:28 -0800
In-Reply-To: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
        (Masahiro Yamada's message of "Sun, 16 Dec 2018 11:50:32 +0900")
Message-ID: <87woo23ek3.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Richard Biener <rguenther@suse.de>, Nadav Amit <namit@vmware.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Michal Marek <michal.lkml@markovi.net>, linux-sparse@vger.kernel.org, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, linux-kbuild@vger.kernel.org
Message-ID: <20181221184428.UJQfB-drQDz7UJCpAz7am1eMzVcVket49SBqvoMzAXs@z>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Revert the following 9 commits:

FWIW the -Wa additional also broke LTO builds because it doesn't really
support -Wa for individual files.

So I'm glad they got reverted.

-Andi
