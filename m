From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp fastpath
Date: Thu, 31 Jul 2014 09:56:48 -0700
Message-ID: <53DA7550.40905@zytor.com>
References: <cover.1406604806.git.luto@amacapital.net> <20140729192056.GA6308@redhat.com> <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com> <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com> <20140730165940.GB27954@localhost.localdomain> <CALCETrUafpWfnbfZzgu3qSGqyxcG0+6A=A1RE8g++=GrQKD93Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <CALCETrUafpWfnbfZzgu3qSGqyxcG0+6A=A1RE8g++=GrQKD93Q@mail.gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Andy Lutomirski <luto@amacapital.net>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@plumgrid.com>, Will Drewry <wad@chromium.org>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 07/30/2014 10:25 AM, Andy Lutomirski wrote:
> 
> And yet x86_64 has this code implemented in assembly even in the
> slowpath.  Go figure.
> 

There is way too much assembly in entry_64.S probably because things
have been grafted on, ahem, "organically".  It is darn nigh impossible
to even remotely figure out what goes on in that file.

	-hpa
