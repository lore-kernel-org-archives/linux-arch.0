From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v2 2/7] tables.h: add linker table support
Date: Tue, 23 Feb 2016 15:08:24 -0800
Message-ID: <CAB=NE6W8H=Sc+1gCBfua8A=qW09CrJxTpCm4Ag_qDrj_Lr6LKw@mail.gmail.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-3-git-send-email-mcgrof@kernel.org> <56C77A53.6060708@zytor.com>
 <20160219214856.GX25240@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <20160219214856.GX25240@wotan.suse.de>
Sender: owner-linux-security-module@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, David Miller <davem@davemloft.net>, Masami Hiramatsu <masami.hiram>
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 19, 2016 at 1:48 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Fri, Feb 19, 2016 at 12:25:55PM -0800, H. Peter Anvin wrote:
>> On 02/19/2016 05:45 AM, Luis R. Rodriguez wrote:
>> > +
>> > +/**
>> > + * DOC: Regular linker linker table constructors
>> > + *
>> > + * Regular constructors are expected to be used for valid linker table entries.
>> > + * Valid uses of weak entries other than the beginning and is currently
>> > + * untested but should in theory work.
>> > + */
>> > +
>> > +/**
>> > + * LINKTABLE_TEXT - Declares a linker table entry for execution
>> > + *
>> > + * @name: linker table name
>> > + * @level: order level
>> > + *
>> > + * Declares a linker table to be used for execution.
>> > + */
>> > +#define LINKTABLE_TEXT(name, level)                                        \
>> > +         __typeof__(name[0])                                       \
>> > +         __attribute__((used,                                      \
>> > +                        __aligned__(LINKTABLE_ALIGNMENT(name)),    \
>> > +                        section(SECTION_TBL(SECTION_TEXT, name, level))))
>>
>> I'm really confused by this.  Text should obviously be readonly,
>
> So this uses SECTION_TEXT, so we just pegged the linker table entry right below
> the standard SECTION_TEXT:

OK yes I see the issue now. I've modified this to use const, and
retested the kprobe patch and it works well still. kprobe would not
use LINKTABLE_TEXT, instead it uses its own macro, however users of
LINKTABLE_TEXT would then have const declared. The implications are
that you *can* declare structs so long as everything is const.

Folks may at times need to modify the structural definitions -- for
that LINKTABLE_DATA() is more appropriate, and as per my testing it
still allows execution of callbacks. I can document this.

Do we want .init.text to match this? I'd port my "struct x86_init_fn"
to use LINKTABLE_INIT_DATA() then. FWIW below is a paste of a simple
test program that demos what I mean.

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/workqueue.h>
#include <linux/tables.h>

static void stuff_todo(struct work_struct *work);
static DECLARE_WORK(stuff_work, stuff_todo);

struct stuff {
int a;
int b;
void (*print_a)(struct stuff *);
void (*print_b)(struct stuff *);

void (*print_a_ro)(const struct stuff *);
void (*print_b_ro)(const struct stuff *);
};

void print_a(struct stuff *s)
{
pr_info("print_a a: %d\n", s->a);
}

void print_a_ro(const struct stuff *s)
{
pr_info("print_a a: %d\n", s->a);
}

void print_b(struct stuff *s)
{
pr_info("print_b b: %d\n", s->b);
}

void print_b_ro(const struct stuff *s)
{
pr_info("print_b b: %d\n", s->b);
}

DEFINE_LINKTABLE_TEXT(struct stuff, my_stuff_fns_ro);
DEFINE_LINKTABLE_DATA(struct stuff, my_stuff_fns);

static LINKTABLE_TEXT(my_stuff_fns_ro, 0000) stuff_a_ro = {
.a = 1,
.b = 1,
.print_a_ro = print_a_ro,
.print_b_ro = print_b_ro,
};

static LINKTABLE_TEXT(my_stuff_fns_ro, 0000) stuff_b_ro = {
.a = 2,
.b = 2,
.print_a_ro = print_a_ro,
.print_b_ro = print_b_ro,
};

static LINKTABLE_TEXT(my_stuff_fns_ro, 0000) stuff_c_ro = {
.a = 3,
.b = 3,
.print_a_ro = print_a_ro,
.print_b_ro = print_b_ro,
};

static LINKTABLE_DATA(my_stuff_fns, 0000) stuff_a = {
.a = 1,
.b = 1,
.print_a = print_a,
.print_b = print_b,
};

static LINKTABLE_DATA(my_stuff_fns, 0000) stuff_b = {
.a = 2,
.b = 2,
.print_a = print_a,
.print_b = print_b,
};

static void stuff_todo(struct work_struct *work)
{
struct stuff *s;
const struct stuff *s_ro;
unsigned int i = 0;

pr_info("Looping over my_stuff_fns_ro\n");

LINKTABLE_FOR_EACH(s_ro, my_stuff_fns_ro) {
pr_info("Looping on s ro %d\n", i++);
s_ro->print_a_ro(s_ro);
s_ro->print_b_ro(s_ro);
}

i=0;
pr_info("Looping over my_stuff_fns\n");

LINKTABLE_FOR_EACH(s, my_stuff_fns) {
pr_info("Looping on s %d\n", i++);
s->print_a(s);
s->print_b(s);
}

i=0;
pr_info("Looping over my_stuff_fns and creating modifications\n");

LINKTABLE_FOR_EACH(s, my_stuff_fns) {
s->a = 10;
s->b = 10;
s->print_a(s);
s->print_b(s);
}
}

static int __init stuff_init(void)
{
/* get out of __init context */
schedule_work(&stuff_work);
return 0;
}

static void __exit stuff_exit(void)
{
cancel_work_sync(&stuff_work);
}

module_init(stuff_init)
module_exit(stuff_exit)
MODULE_LICENSE("GPL");


  Luis
