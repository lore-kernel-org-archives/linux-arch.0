From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: m68k: include: asm: the 3rd parameter of 'insl'
 and 'outsl' need '<< 2'
Date: Wed, 05 Jun 2013 08:35:43 +0800
Message-ID: <51AE87DF.5000301@asianux.com>
References: <51A71E49.1000707@asianux.com> <CAMuHMdUz8o4d=RiAMW8-pCrnZyfoH9EETVqjcb7E1GqCgYmQ7g@mail.gmail.com> <51A93FA0.1050203@biophys.uni-duesseldorf.de> <51A94281.7050708@biophys.uni-duesseldorf.de> <51AC6472.3060606@asianux.com> <CAMuHMdVLA_zgeGxTTzfXnBYZiihH3w+LLcW0cRzVk_dvkFojgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVLA_zgeGxTTzfXnBYZiihH3w+LLcW0cRzVk_dvkFojgg@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: schmitz <schmitz@biophys.uni-duesseldorf.de>, Greg Ungerer <gerg@uclinux.org>, schmitz@debian.org, Sam Ravnborg <sam@ravnborg.org>, Greg KH <gregkh@linuxfoundation.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 06/03/2013 06:48 PM, Geert Uytterhoeven wrote:
>>> >> This _only_ applies to use of insl/outsl macros in parport_pc.h, which
>>> >> is only used by Q40 on m68k. I see no reason to change anything in io.h
>>> >> to cope with this warning.

I guess your meaning is :

----------------------------diff begin----------------------------------

diff --git a/arch/m68k/include/asm/parport.h b/arch/m68k/include/asm/parport.h
index 5ea75e6..dd1672a 100644
--- a/arch/m68k/include/asm/parport.h
+++ b/arch/m68k/include/asm/parport.h
@@ -11,9 +11,20 @@
 #ifndef _ASM_M68K_PARPORT_H
 #define _ASM_M68K_PARPORT_H 1
 
+#ifdef CONFIG_Q40 /* for Q40, need redefine insl/outsl */
+
+#ifdef insl
+#undef insl
+#endif
 #define insl(port,buf,len)   isa_insb(port,buf,(len)<<2)
+
+#ifdef outsl
+#undef outsl
+#endif
 #define outsl(port,buf,len)  isa_outsb(port,buf,(len)<<2)
 
+#endif /* CONFIG_Q40 */
+
 /* no dma, or IRQ autoprobing */
 static int parport_pc_find_isa_ports (int autoirq, int autodma);
 static int parport_pc_find_nonpci_ports (int autoirq, int autodma)

----------------------------diff end------------------------------------


>> >
>> > It sounds reasonable.
>> >
>> > And excuse me, could you provide the related link directly ?  I don't
>> > know how to see the detail of 'loom.20130511T171757-995@post.gmane.org'.
> http://www.spinics.net/lists/linux-m68k/msg06041.html

OK, thanks.  And sorry for replying late (during these days, I have to
do another things, and almost can not connect net).

It seems already has another related patch for it, and it is just
applying.

So need I send it again ?




Thanks.
-- 
Chen Gang

Asianux Corporation
