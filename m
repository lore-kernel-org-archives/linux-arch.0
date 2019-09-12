Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtpcmd04131.aruba.it ([62.149.158.131]:34943 "EHLO
        smtpcmd04131.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731788AbfILMzK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Sep 2019 08:55:10 -0400
Subject: Re: [PATCH 1/2] tty: add bits to manage multidrop mode
References: <20190912084032.16927-1-giometti@enneenne.com>
 <20190912084032.16927-2-giometti@enneenne.com>
 <c9860c7f-bd06-86aa-c3c0-74e2e1617cae@gmail.com>
From: Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <c7a63468-4e29-2bbd-912d-4583098507af@enneenne.com>
Date: Thu, 12 Sep 2019 14:47:59 +0200
MIME-Version: 1.0
In-Reply-To: <c9860c7f-bd06-86aa-c3c0-74e2e1617cae@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Genoud <richard.genoud@gmail.com>, linux-arch@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Rodolfo Giometti <giometti@linux.it>, Joshua Henderson <joshua.henderson@microchip.com>

On 12/09/2019 13:01, Richard Genoud wrote:
> Hi Rodolfo,
> 
> You could also add these mailing lists:
> - linux-serial@vger.kernel.org
> - linux-arm-kernel@lists.infradead.org
> - linux-kernel@vger.kernel.org

OK. No problem!

> For reference, I've dug the conversation we had 2 years ago:
> 0/2 : https://marc.info/?t=149192176100002&r=1&w=2
> 1/2 : https://marc.info/?t=149192176300001&r=1&w=2
> 2/2 : https://marc.info/?t=149192176700001&r=1&w=2

Thanks.

> And, like I said at that time, one problem I see with this
> implementation (setting a SENDA bit that automatically unsets itself)
> will break the way tcgetattr() is working:
> https://marc.info/?l=linux-serial&m=149209522108027&w=2

I see... however the problem here is that this attribute is not sticky and it is
reset by the controller after the first byte as been sent. Here is how
Atmel/Microchip multidrop works (from the SAMA5D3's datasheet):

44.7.3.9 Multidrop Mode
If the value 0x6 or 0x07 is written to the PAR field in the US_MR, the USART
runs in Multidrop Mode. This mode differentiates the data characters and the
address characters. Data is transmitted with the parity bit to 0 and addresses
are transmitted with the parity bit to 1.
...
The transmitter sends an address byte (parity bit set) when SENDA is written to
in the US_CR. In this case, the next byte written to the US_THR is transmitted
as an address. Any character written in the US_THR without having written the
command SENDA is transmitted normally with the parity to 0.

So, if we have a 4 bytes message where the first one is the address byte we can
use multidrop by setting the SENDA bit at the beginning and then by just
invoking a write() with the four bytes message. The controller automatically
will set the 9th bit to 1 for the first byte and then to 0 for the following
three bytes.

To do so we need a syscall to tell to the controller when the address bit
(SENDA) must be set, each time, before sending the message.

In this implementation I used the syscall within tcsetattr() function but if
this is not right, then I have to use another one... maybe a custom ioctl? Or
can you please suggest a suitable solution? :-)

Thanks for your help,

Rodolfo Giometti

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
