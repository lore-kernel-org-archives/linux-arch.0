From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: Can this be a invalid memory access? (was: Re: [PATCH]
 spi/xilinx: Cast ioread32/iowrite32 function pointers)
Date: Mon, 2 Feb 2015 15:05:03 +0100
Message-ID: <CAPybu_3mx4Zey6uS=pQhwq6HKvkszcsq6S7NXDjq4Mic_yn_hQ@mail.gmail.com>
References: <CAPybu_16LBPDjuhL-Vw-rqFK-13+gLHrRc-3KuYwUTi0XyDX7Q@mail.gmail.com>
 <CAMuHMdXsUZD5PW2AmCg-uFZRm5M5p9kFO6XyjKUbjrwN+BMTKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:58424 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbbBBOFZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Feb 2015 09:05:25 -0500
In-Reply-To: <CAMuHMdXsUZD5PW2AmCg-uFZRm5M5p9kFO6XyjKUbjrwN+BMTKw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hello Geert

On Mon, Feb 2, 2015 at 2:04 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>> void * pvar=varB;
>
> ... = &varB;
>
>> *pvar = ioread8(valid_memory);
>>
>> Depending if ioread8 returns a u8 or a unsigned int, aren't we also
>> accessing varC?
>>
>> Could not this be a problem?
>
> Please try to compile the above.
> The compiler will tell you you cannot dereference a void pointer.
>
> Now, replace "void *" by "unsigned int *".
> After that, varC will indeed be overwritten. But the compiler will still have
> warned you that you assigned the address of an u8 variable to an
> unsigned int pointer.

I am still a bit worried, that the same function has different
prototypes and implementations depending on the arch.  But
"unfortunately" I cannot make a counter-example that can cause an
error.

So far, the closest I have get is this:

ricardo@neopili:/tmp$ cat arch.c
#include <stdint.h>

unsigned int my_ioread8(){
return 0xdeadbeef;
}

void test_read();
int main(int argc, char *argv[]){

test_read();
return 0;
}


ricardo@neopili:/tmp$ cat io.h
#ifndef IO_H
#define IO_H
#include <stdint.h>

uint8_t my_ioread8();

#endif


ricardo@neopili:/tmp$ cat driver.c
#include "io.h"
#include <stdint.h>
#include <stdio.h>

void test_read(){
uint8_t varA=0x1;
uint8_t varB=0x2;
uint8_t varC=0x3;

varB = my_ioread8();

fprintf(stdout, "varA=%d varB=%d varC=%d\n",
varA, varB, varC);
}

It does not produce any error at build time:
 ricardo@neopili:/tmp$ make
cc -Wall   -c -o arch.o arch.c
cc -Wall   -c -o driver.o driver.c
cc -Wall arch.o driver.o -o test

and it works fine on amd86

ricardo@neopili:/tmp$ ./test
varA=1 varB=239 varC=3

But in the hypothetical case where the calling convention will be
different for unsigned int and u8, there will be an issue....

The reason that I am interested in this is that I want to be able to
have code like:

struct  priv_data{
   u16 (read *)(void __iomem *);
};

endian=detect_endianness()

if (endian == BIG)
  priv->read= ioread16be;
else
  priv->read= ioread16;

data = priv->read(iomem+DATA);

Unfortunately, with the current code, this does not work on all the
arches, and the workaround is having wrappers for ioread and iowrite
like in drivers/spi/spi-xilinx.c

static void xspi_write32(u32 val, void __iomem *addr)
{
iowrite32(val, addr);
}

static void xspi_write32_be(u32 val, void __iomem *addr)
{
iowrite32be(val, addr);
}



Regards




-- 
Ricardo Ribalda
