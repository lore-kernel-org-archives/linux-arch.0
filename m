From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] arch: use ASM_NL instead of ';' for assembler new line
 character in the macro
Date: Tue, 29 Oct 2013 12:34:30 +0400
Message-ID: <CAMo8BfK3FfQ+Gh=XMnaHZQqDayNN455DgMcbnKZBQTumC+_WmA@mail.gmail.com>
References: <526E3CE2.2070405@asianux.com>
	<CAMo8BfK70vRc_DUTXhUZfTjA7zvYW3D4ApgDoMrwUZp5c+qk1g@mail.gmail.com>
	<526F6A4F.9040507@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <526F6A4F.9040507@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: "vgupta@synopsys.com" <vgupta@synopsys.com>, James Hogan <james.hogan@imgtec.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 29, 2013 at 11:57 AM, Chen Gang <gang.chen@asianux.com> wrote:
> On 10/28/2013 07:18 PM, Max Filippov wrote:
>> Hi Chen,
>>
>> On Mon, Oct 28, 2013 at 2:30 PM, Chen Gang <gang.chen@asianux.com> wrote:
>>> > For some toolchains, they use another character as newline in a macro
>>> > (e.g. arc uses '`'), so for generic assembly code, need use ASM_NL (a
>>> > macro) instead of ';' for it.
>>> > Since "linux/export.h" are mainly used for exporting work, then our fix
>>> > more likely belongs to "linux/linkage.h", and we need add the related
>>> > checking in "linkage.h".
>>> >
>>> > Also need notice 80 columns wrap, and '\t' for each line.
>>> >
>>> >
>>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>> > ---
>>> >  arch/arc/include/asm/linkage.h    |    2 +
>>> >  include/asm-generic/vmlinux.lds.h |  350 +++++++++++++++++++------------------
>> Actually vmlinux.lds.h is not an assembly code, but rather a linker script,
>> later preprocessed by cpp.
>>
>
> Consult: do xtensa also has its own ASM_NL?

It works well with common semicolon.

-- 
Thanks.
-- Max
