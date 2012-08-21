From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 16/31] arm64: ELF definitions
Date: Tue, 21 Aug 2012 20:17:19 +0200
Message-ID: <CAMuHMdVEX0egzFETMJ=LA_PB+7Qc=Ph-7uxofVr__wOE-0cvLQ@mail.gmail.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208151415.39570.arnd@arndb.de>
 <20120816102300.GG31784@mudshark.cambridge.arm.com>
 <201208161237.53594.arnd@arndb.de> <20120821160653.GH12708@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120821160653.GH12708@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 21, 2012 at 6:06 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> But I can see on x86 that it always reports x86_64 even if the task is
> x86_32.

Really?

$ uname -m
x86_64
$ linux32 uname -m
i686
$

On Ubuntu 2.6.32-42-generic

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
