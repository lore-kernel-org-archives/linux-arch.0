From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
Date: Tue, 29 Oct 2019 21:37:12 +0100
Message-ID: <e9835376-1efe-1d1b-4a99-8bb920e04a08@rasmusvillemoes.dk>
References: <20191029200026.9790-1-jim.cromie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191029200026.9790-1-jim.cromie@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc: greg@kroah.com, Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 29/10/2019 21.00, Jim Cromie wrote:
> dyndbg populates its callsite info into __verbose section, change that
> to a more specific and descriptive name, __dyndbg.

Yeah, that has always bugged me. Ack to that part.

> Also, per checkpatch:
>   move extern struct _ddebug __(start|stop)__dyndbg[] to header file

Hm, why? checkpatch should often be ignored. Since we only refer to
those symbols in the .c file, there's no reason to pollute every other
translation unit with those declarations. Having declarations in a
header makes sense when the actual entity gets defined in some .c file
(which hopefully also includes the header). But these are defined by the
linker, so there's no type safety to be had.

>   simplify __attribute(..) to __section(__dyndbg) declaration.

Makes sense, since you're munching the thing anyway.

Rasmus
