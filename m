From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Wed, 14 Dec 2016 10:37:12 +0100
Message-ID: <20161214093712.GA13721@sepie.suse.cz>
References: <1480559754.16599.92.camel@decadent.org.uk>
 <20161201143928.07a08348@roar.ozlabs.ibm.com>
 <6e8cf20b-2d2f-ba1f-e02c-c757d5a25db7@suse.com>
 <20161209133308.0acbb57a@roar.ozlabs.ibm.com>
 <1481296893.4509.135.camel@hellion.org.uk>
 <20161210021529.4a6e684f@roar.ozlabs.ibm.com>
 <86vaus3eld.fsf@seketeli.org>
 <f7c5d50d-8930-7ab1-62bb-8a5d0aead988@suse.com>
 <867f72vqec.fsf@seketeli.org>
 <20161214091539.GA9000@sepie.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <20161214091539.GA9000@sepie.suse.cz>
Resent-Message-ID: <hWJjdoLyHyO.A.uQG.BbRUYB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20161214093712.GA13721@sepie.suse.cz
To: Dodji Seketeli <dodji@seketeli.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ian Campbell <ijc@hellion.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 2016-12-14 10:15, Michal Marek wrote:
> A minimal example would be
> 
> t1.c:
> struct s1;
> struct s2 {
> 	int i;
> }
> struct s3 {
> 	struct s1 *ptr1;
> 	struct s2 *ptr2;
> }
> void foo(struct s3*);
> EXPORT_SYMBOL(foo);
> 
> t2.c:
> struct s1 {
> 	int j;
> }
> struct s2;
> struct s3 {
> 	struct s1 *ptr1;
> 	struct s2 *ptr2;
> }
> void foo(struct s3*);
> EXPORT_SYMBOL(foo);

Note that the above, if passed to genksyms verbatim, would result in
genksyms treating all the types as internal. Here is a complete
example including linemarkers:

$ cat t1.i
# 1 "t1.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "t1.c"
# 1 "t1.h" 1
# 1 "t.h" 1
struct s1;
struct s2;
struct s3 {
 struct s1 *ptr1;
 struct s2 *ptr2;
};
# 2 "t1.h" 2
struct s2 {
 int i;
};
# 2 "t1.c" 2
void foo(struct s3 *s) { }
EXPORT_SYMBOL(foo);

$ cat t2.i
# 1 "t2.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "t2.c"
# 1 "t2.h" 1
# 1 "t.h" 1
struct s1;
struct s2;
struct s3 {
 struct s1 *ptr1;
 struct s2 *ptr2;
};
# 2 "t2.h" 2
struct s1 {
 int j;
};
# 2 "t2.c" 2
void foo(struct s3 *s) { }
EXPORT_SYMBOL(foo);

$ ./scripts/genksyms/genksyms -D <t1.i 
Export foo == <void foo ( struct s3 { struct s1 { UNKNOWN } * ptr1 ; struct s2 { int i ; } * ptr2 ; } * ) >
__crc_foo = 0xf731cef8 ;

$ ./scripts/genksyms/genksyms -D <t2.i 
Export foo == <void foo ( struct s3 { struct s1 { int j ; } * ptr1 ; struct s2 { UNKNOWN } * ptr2 ; } * ) >
__crc_foo = 0xc925dae5 ;

Michal
