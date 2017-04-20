From: "dongbo (E)" <dongbo4@huawei.com>
Subject: Re: [PATCH] fs: Preventing READ_IMPLIES_EXEC Propagation
Date: Thu, 20 Apr 2017 11:50:38 +0800
Message-ID: <edd83c82-7800-b1ca-2069-3b40cefa93d3@huawei.com>
References: <1492088223-98232-1-git-send-email-zhangshaokun@hisilicon.com>
 <2414e3b3-03f6-bd6c-5aa4-ad58c66b5aa5@huawei.com>
 <20170418170118.GH27592@e104818-lin.cambridge.arm.com>
 <CAFEAcA_wH1dDbcjEEBaLX0q8pfWsfYUGGL-zOC4MuxySqa=uvA@mail.gmail.com>
 <20170419103313.GA3238@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170419103313.GA3238@e104818-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Peter Maydell <peter.maydell@linaro.org>, linux@armlinux.org.uk
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Maydell <Peter.Maydell@arm.com>, Will Deacon <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, arm-mail-list <linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2017/4/19 18:33, Catalin Marinas wrote:
> On Tue, Apr 18, 2017 at 09:01:52PM +0100, Peter Maydell wrote:
>> On 18 April 2017 at 18:01, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>> On Thu, Apr 13, 2017 at 08:33:52PM +0800, dongbo (E) wrote:
>>>> From: Dong Bo <dongbo4@huawei.com>
>>>>
>>>> In load_elf_binary(), once the READ_IMPLIES_EXEC flag is set,
>>>> the flag is propagated to its child processes, even the elf
>>>> files are marked as not requiring executable stack. It may
>>>> cause superfluous operations on some arch, e.g.
>>>> __sync_icache_dcache on aarch64 due to a PROT_READ mmap is
>>>> also marked as PROT_EXEC.
>>>>
>>>> Signed-off-by: Dong Bo <dongbo4@huawei.com>
>>>> ---
>>>>  fs/binfmt_elf.c       | 2 ++
>>>>  fs/binfmt_elf_fdpic.c | 2 ++
>>>>  2 files changed, 4 insertions(+)
>>>>
>>>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>>>> index 5075fd5..c52e670 100644
>>>> --- a/fs/binfmt_elf.c
>>>> +++ b/fs/binfmt_elf.c
>>>> @@ -863,6 +863,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
>>>>  	SET_PERSONALITY2(loc->elf_ex, &arch_state);
>>>>  	if (elf_read_implies_exec(loc->elf_ex, executable_stack))
>>>>  		current->personality |= READ_IMPLIES_EXEC;
>>>> +	else
>>>> +		current->personality &= ~READ_IMPLIES_EXEC;
>>>>   	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
>>>> 		current->flags |= PF_RANDOMIZE;
>>>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>>>> index cf93a4f..c4bc4d0 100644
>>>> --- a/fs/binfmt_elf_fdpic.c
>>>> +++ b/fs/binfmt_elf_fdpic.c
>>>> @@ -354,6 +354,8 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>>>>  		set_personality(PER_LINUX);
>>>>  	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
>>>>  		current->personality |= READ_IMPLIES_EXEC;
>>>> +	else
>>>> +		current->personality &= ~READ_IMPLIES_EXEC;
>>>>   	setup_new_exec(bprm);
>>
>>> That's affecting most architectures with a risk of ABI breakage. We
>>> could do it on arm64 only, though I'm not yet clear on the ABI
>>> implications (at a first look, there shouldn't be any).
>>
>> Is there a reason why it isn't just straightforwardly a bug
>> (which we could fix) to make READ_IMPLIES_EXEC propagate to
>> child processes?
> 
> While I agree that it looks like a bug, if there are user programs
> relying on such bug we call it "ABI". On arm64, I don't think there is
> anything relying on inheriting READ_IMPLIES_EXEC but I wouldn't change
> the compat task handling without the corresponding change in arch/arm.
> 

With READ_IMPLIES_EXEC propagation, several hundreds times of
__sync_icache_dcache operations shows up than not READ_IMPLIES_EXEC
propagation, which degenerating the system performance. Changing arm64
only would settle our problem down, thanks for figuring out previously.

Seems that arch/arm had discussed the propagation of READ_IMPLIES_EXEC:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/086490.html
But the READ_IMPLIES_EXEC is still not cleared in elf_set_personality().

>> AFAICT this should be per-process: just because
>> init happens not to have been (re)compiled to permit non-executable
>> stacks doesn't mean every process on the system needs to have
>> an executable stack.
> 
> I think this also affects the heap if brk(2) is used (via
> VM_DATA_DEFAULT_FLAGS though I guess malloc mostly uses mmap these
> days).
> 
>> Behaviour shouldn't be variable across architectures either, I would
>> hope.
> 
> The behaviour has already been variable for a long time. Even on x86,
> AFAICT x86_32 differs from x86_64 in this respect.
> 
> Anyway, the patch should be posted to linux-arch for a cross-arch
> discussion.
> 

OK, this mail Cc to linux-arch. Thanks.
