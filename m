From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Post-merge-window ping (Re: [PATCH v4 0/5] x86: two-phase syscall
 tracing and seccomp fastpath)
Date: Fri, 05 Sep 2014 13:43:44 -0700
Message-ID: <540A2080.8050404@zytor.com>
References: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com> <540A1800.3000005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <540A1800.3000005@zytor.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Andy Lutomirski <luto@amacapital.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, Frederic Weisbecker <fweisbec@gmail.com>
List-Id: linux-arch.vger.kernel.org

On 09/05/2014 01:07 PM, H. Peter Anvin wrote:
> On 08/26/2014 06:32 PM, Andy Lutomirski wrote:
>> On Mon, Jul 28, 2014 at 8:38 PM, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>>> This applies to:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccom=
p-fastpath
>>>
>>> Gitweb:
>>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=3D=
seccomp/fastpath
>>
>> Hi all-
>>
>> AFAIK the only thing that's changed since I submitted it is that the
>> 3.17 merge window is closed.  Kees rebased the tree this applies to,
>> but I think the patches all still apply.  What, if anything, do I ne=
ed
>> to do to help this along for 3.18?
>>
>=20
> Just put this stuff in a branch and running through my personal test
> battery now.
>=20

=2E.. and they fail build testing.  Specifically, both i386 and x86-64
allnoconfig fail with:

arch/x86/kernel/ptrace.c: In function =E2=80=98syscall_trace_enter_phas=
e2=E2=80=99:
  LD      fs/quota/built-in.o
=2E./arch/x86/kernel/ptrace.c:1579:2: error: implicit declaration of
function =E2=80=98seccomp_phase2=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
  if (phase1_result > 1 && seccomp_phase2(phase1_result)) {
  ^
cc1: some warnings being treated as errors
  CC      arch/x86/kernel/step.o
make[4]: *** [arch/x86/kernel/ptrace.o] Error 1

	-hpa
