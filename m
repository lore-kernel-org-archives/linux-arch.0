From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH] Xen: remove -fshort-wchar gcc flag
Date: Thu, 11 Aug 2016 08:06:52 -0600
Message-ID: <57ACA29C0200007800105235@prv-mh.provo.novell.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
 <16541778.WMH6K24aDt@wuerfel>
 <57AC90F5020000780010515A@prv-mh.provo.novell.com>
 <1924668.nNs2RHZJcd@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1924668.nNs2RHZJcd@wuerfel>
Content-Disposition: inline
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, David Vrabel <david.vrabel@citrix.com>, Alan Modra <amodra@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Segher Boessenkool <segher@kernel.crashing.org>, Nicolas Pitre <nico@linaro.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Sam Ravnborg <sam@ravnborg.org>, Juergen Gross <JGross@suse.com>, Michal Marek <MMarek@suse.com>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

>>> On 11.08.16 at 16:01, <arnd@arndb.de> wrote:
> On Thursday, August 11, 2016 6:51:33 AM CEST Jan Beulich wrote:
>> >>> On 11.08.16 at 14:39, <arnd@arndb.de> wrote:
>> > A previous patch added the --no-wchar-size-warning to the Makefile to
>> > avoid this harmless warning:
>> > 
>> > arm-linux-gnueabi-ld: warning: drivers/xen/efi.o uses 2-byte wchar_t yet the 
>> > output is to use 4-byte wchar_t; use of wchar_t values across objects may 
>> > fail
>> > 
>> > Changing kbuild to use thin archives instead of recursive linking
>> > unfortunately brings the same warning back during the final link.
>> > 
>> > This time, we remove the -fshort-wchar flag that originally caused
>> > the warning, hopefully fixing the problem for good. I don't see
>> > any reason for having the flag in the first place, as the Xen code
>> > does not use wchar_t at all.
>> 
>> It uses efi_char16_t, and by dropping -fshort-wchar you'd open
>> up a trap for anyone to fall into who were to add wide string
>> literals to that same file. EFI using 16-bit characters requires
>> code interfacing with EFI to do so too.
> 
> I don't understand. How is this different from other source files
> that use efi_char16_t or the wchar_t definition from include/linux/nls.h?

Perhaps they didn't run into the issue yet?

> As far as I can tell, they all use 16-bit characters, but none of the
> others sets the flag. Maybe we should just always build with -fshort-wchar
> from the top-level Makefile?

Quite possible, unless elsewhere in the tree 4-byte characters are
needed.

Jan

