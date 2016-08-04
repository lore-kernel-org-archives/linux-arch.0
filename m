From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Generic section maintainers
Date: Thu, 4 Aug 2016 11:47:10 -0700
Message-ID: <dab623e8-cb1a-f680-8d84-685c70f18176@zytor.com>
References: <CAB=NE6VpHJLicvrKhPhQD4p+hNRCpvPJU7AXFAQdxXeDWfPLJQ@mail.gmail.com>
 <20160804042840.k355wibzjp5yikxb@treble>
 <20160804170610.GV3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160804170610.GV3296@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, Borislav Petkov <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joe Perches <joe@perches.com>
List-Id: linux-arch.vger.kernel.org

On 08/04/16 10:06, Luis R. Rodriguez wrote:
>>>
>>> +GENERIC SECTIONS
>>> +M: "Luis R. Rodriguez" <mcgrof@kernel.org>
>>> +M: Josh Poimboeuf <jpoimboe@redhat.com>
>>> +M: Arnd Bergmann <arnd@arndb.de>
>>> +L: linux-arch@vger.kernel.org
>>> +L: linux-kernel@vger.kernel.org
>>> +S: Supported
>>> +F: include/asm-generic/section-core.h
>>> +F: include/asm-generic/sections.h
>>> +F: include/asm-generic/vmlinux.lds.h
>>> +F: Documentation/DocBook/sections.tmpl
>>
>> Hi Luis,
>>
>> Thanks to my past work with objtool and kpatch, I know far more than I
>> ever wanted to know about all the kernel's custom ELF sections.  So it's
>> fine with me if you want to add me as a maintainer for those files.
> 
> OK thanks! I'll fold this into my changes.
> 

You can add me too if you want.

	-hpa
