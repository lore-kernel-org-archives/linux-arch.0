From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 06/32] isofs: fix timestamps beyond 2027
Date: Sat, 31 May 2014 01:47:19 -0700
Message-ID: <53899717.1050109@zytor.com>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>	<1401480116-1973111-7-git-send-email-arnd@arndb.de> <CAMuHMdXn2wzhU6f-qVsFAoVZQOciRbi8ZBdjQpHQf96qRC2kww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXn2wzhU6f-qVsFAoVZQOciRbi8ZBdjQpHQf96qRC2kww@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, John Stultz <john.stultz@linaro.org>, Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ley Foon Tan <lftan@altera.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 05/31/2014 12:59 AM, Geert Uytterhoeven wrote:
> On Fri, May 30, 2014 at 10:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> isofs uses a 'char' variable to load the number of years since
>> 1900 for an inode timestamp. On architectures that use a signed
>> char type by default, this results in an invalid date for
>> anything beyond 2027.
>>
>> This adds a cast to 'u8' for the year number, which should extend
>> the shelf life of the file system until 2155.
> 
> Oops, the CD archive of my scanned Napoleon manuscripts no longer has the
> right file date? ;-)
> 
> Are there any practical uses of representating dates between 1772 and 1900
> on CD/DVD?
> 

Unlikely, furthermore, the spec explicitly states that the number is
unsigned (ref: ECMA-119, 2nd ed, 9.1.5 which specifies that the numbers
are "recorded according to 7.1.1"; 7.1.1 specifies "8-bit unsigned
numerical values").

	-hpa


