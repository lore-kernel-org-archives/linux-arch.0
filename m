From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Thu, 23 Jan 2020 09:59:03 -0800
Message-ID: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
References: <20200123153341.19947-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 23, 2020 at 7:33 AM Will Deacon <will@kernel.org> wrote:
>
> This is version two of the patches I previously posted as an RFC here:

Looks fine to me, as far as I can tell,

              Linus
