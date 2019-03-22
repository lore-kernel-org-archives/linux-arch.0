From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
Date: Fri, 22 Mar 2019 10:07:04 -0700
Message-ID: <CAHk-=wjujKK-Ey7DPnMExaEmphicuEDLmVn-9+W9VzFzR-Ts=A@mail.gmail.com>
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-3-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190322143008.21313-3-longman@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-parisc@vger.kernel.or
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.

Ack.

               Linus
