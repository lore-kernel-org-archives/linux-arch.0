From: Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
Date: Mon, 23 Apr 2018 13:01:31 +0200
Message-ID: <CA+7wUszDBFQRV78stj_MArnZYFp3ug6UoxH+Y__SWC=fGH2g8A@mail.gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
 <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
 <20180420204104.6e22b136@roar.ozlabs.ibm.com>
 <CA+7wUsyWu3eweWjwfFoS5FD5yb3OxjLV4-XyErcNA4fJGPCf8Q@mail.gmail.com>
 <738aa4d6-9313-f484-0510-e965f2881869@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <738aa4d6-9313-f484-0510-e965f2881869@c-s.fr>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: linux-arch@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Christophe,

On Sat, Apr 21, 2018 at 9:16 AM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 20/04/2018 =C3=A0 22:08, Mathieu Malaterre a =C3=A9crit :
>>
>> On Fri, Apr 20, 2018 at 12:41 PM, Nicholas Piggin <npiggin@gmail.com>
>> wrote:
>>>
>>> On Fri, 20 Apr 2018 12:00:49 +0200
>>> Mathieu Malaterre <malat@debian.org> wrote:
>>>
>>>> On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com>
>>>> wrote:
>>>>>
>>>>> This requires further changes to linker script to KEEP some tables
>>>>> and wildcard compiler generated sections into the right place. This
>>>>> includes pp32 modifications from Christophe Leroy.
>>>>>
>>>>> When compiling powernv_defconfig with this option:
>>>>>
>>>>> text       data      bss       dec        filename
>>>>> 11827621   4810490   1341080   17979191   vmlinux
>>>>> 11752437   4598858   1338776   17690071   vmlinux.dcde
>>>>>
>>>>> Resulting kernel is almost 400kB smaller (and still boots).
>>>>>
>>>>> [ppc32 numbers here]
>>>>
>>>>
>>>> ^^^
>>>>
>>>> Do you want somebody else to provide those numbers ?
>>>
>>>
>>> If you have a booting kernel, yes some more numbers would be good.
>>
>>
>> I've used /boot/config-4.15.0-2-powerpc from my current debian
>> package. Rebuild master with and without option, boot ok, load/unload
>> module ok.
>>
>> $ size nick/vmlinux.with*
>>     text    data     bss     dec     hex filename
>> 7386425 2364370 1425432 11176227 aa8923 nick/vmlinux.with
>> 7461457 2475122 1428064 11364643 ad6923 nick/vmlinux.without
>>
>> This is not clear why with option the size of kernel is slightly bigger:
>
>
> The file contains also debug symbols, which might differ.
> Only the LOAD part of the file is interesting, that's the part you get wh=
en
> doing ppc-linux-objcopy vmlinux vmlinux.bin -O binary
>
> You can see it with readelf -l vmlinux

Here is what I see:

$ diff -u <(readelf -l nick/vmlinux.with) <(readelf -l nick/vmlinux.without=
)
--- /proc/self/fd/11 2018-04-23 12:59:52.413101612 +0200
+++ /proc/self/fd/12 2018-04-23 12:59:52.417101567 +0200
@@ -5,9 +5,9 @@

 Program Headers:
   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
-  LOAD           0x010000 0xc0000000 0x00000000 0x950f34 0xaad018 RWE 0x10=
000
-  NOTE           0x867640 0xc0857640 0x00857640 0x00024 0x00024     0x4
-  NOTE           0x867664 0xc0857664 0x00857664 0x0000c 0x0000c     0x1
+  LOAD           0x010000 0xc0000000 0x00000000 0x97ef34 0xadba68 RWE 0x10=
000
+  NOTE           0x87f640 0xc086f640 0x0086f640 0x00024 0x00024     0x4
+  NOTE           0x87f664 0xc086f664 0x0086f664 0x0000c 0x0000c     0x1

  Section to Segment mapping:
   Segment Sections...


> Christophe
>
>>
>> $ du -sk nick/vmlinux.with*
>> 124488 nick/vmlinux.with
>> 124004 nick/vmlinux.without
>>
>>
>>> Thanks,
>>> Nick
>
>
> ---
> L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=
=C3=A9rifi=C3=A9e par le
> logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
