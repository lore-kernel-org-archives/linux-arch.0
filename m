From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: [patch] Performance Counters for Linux, v2
Date: Fri, 09 Jan 2009 09:07:30 +0800
Message-ID: <1231463250.2711.74.camel@ymzhang>
References: <20081208012211.GA23106@elte.hu>
	 <20081207174932.09673cae@infradead.org>  <20081208114921.GA8635@elte.hu>
	 <1231314196.2711.48.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:48537 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756457AbZAIBHj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jan 2009 20:07:39 -0500
In-Reply-To: <1231314196.2711.48.camel@ymzhang>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>

On Wed, 2009-01-07 at 15:43 +0800, Zhang, Yanmin wrote:
> On Mon, 2008-12-08 at 12:49 +0100, Ingo Molnar wrote:
> > * Arjan van de Ven <arjan@infradead.org> wrote:
> >=20
> > > On Mon, 8 Dec 2008 02:22:12 +0100
> > > Ingo Molnar <mingo@elte.hu> wrote:
> > >=20
> > > >=20
> > > > [ Performance counters are special hardware registers available=
 on
> > > > most modern CPUs. These register count the number of certain ty=
pes of
> > > > hw events: such as instructions executed, cachemisses suffered,=
 or=20
> > > >   branches mis-predicted, without slowing down the kernel or=20
> > > >   applications. These registers can also trigger interrupts whe=
n a=20
> > > >   threshold number of events have passed - and can thus be used=
 to=20
> > > >   profile the code that runs on that CPU. ]
> > > >=20
> > > > This is version 2 of our Performance Counters subsystem
> > > > implementation.
> > > >=20
> > > > The biggest user-visible change in this release is a new user-s=
pace=20
> > > > text-mode profiling utility that is based on this code: KernelT=
op.
> > > >=20
> > > > KernelTop can be downloaded from:
> > > >=20
> > > >   http://redhat.com/~mingo/perfcounters/kerneltop.c
> > > >=20
> > > > It's a standalone .c file that needs no extra libraries - it on=
ly
> > > > needs a CONFIG_PERF_COUNTERS=3Dy kernel to run on.
> > > >=20
> > > > This utility is intended for kernel developers - it's basically=
 a
> > > > dynamic kernel profiler that gets hardware counter events dispa=
tched
> > > > to it continuously, which it feeds into a histogram and outputs=
 it=20
> > > > periodically.
> > > >=20
> > >=20
> > > I played with this a little, and while it works neat, I wanted a=20
> > > feature added where it shows a detailed profile for the top funct=
ion.
> >=20
> > ah, very nice idea!
> >=20
> > > I've hacked this in quickly (the usability isn't all that great y=
et)=20
> > > and put the source code up at
> > >
> > > http://www.tglx.de/~arjan/kerneltop-0.02.tar.gz
> >=20
> > ok, picked it up :-)
> Ingo,
>=20
> I try to use patch V5 and the latest kerneltop to collect some cachem=
iss data.
>=20
> It seems kerneltop just shows the first instruction ip address of fun=
ctions. Does
> the latest kerneltop include the enhancement from Arjan? As you know,=
 with oprofile,
> we can get detailed instrument ip address which causes the cache miss=
 although the ip
> address should go back one instruction mostly.
=EF=BB=BFAs a matter of fact, the original kerneltop has parameter -s t=
o support it. But
kerneltop has a bug to show details of the symbol. =EF=BB=BFsym_filter_=
entry should be initiated
after qsort.

below is an example.
#./kerneltop --vmlinux=3D/root/linux-2.6.28_slqb1230flush/vmlinux -d 20=
 -e 3 -f 1000 -s flush_free_list

-----------------------------------------------------------------------=
-------
 KernelTop:   20297 irqs/sec  [NMI, 10000 cache-misses],  (all, 8 CPUs)
-----------------------------------------------------------------------=
-------

             events         RIP          kernel function
  ______     ______   ________________   _______________

           12816.00 - ffffffff803d5760 : copy_user_generic_string!
           11751.00 - ffffffff80647a2c : unix_stream_recvmsg
           10215.00 - ffffffff805eda5f : sock_alloc_send_skb
            9738.00 - ffffffff80284821 : flush_free_list
            6749.00 - ffffffff802854a1 : __kmalloc_track_caller
            3663.00 - ffffffff805f09fa : skb_dequeue
            3591.00 - ffffffff80284be2 : kmem_cache_alloc       [qla2xx=
x]
            3501.00 - ffffffff805f15f5 : __alloc_skb
            1296.00 - ffffffff803d8eb4 : list_del       [qla2xxx]
            1110.00 - ffffffff805f0ed2 : kfree_skb
Showing details for flush_free_list
       0        ffffffff8028488a:       78 00 00=20
       0        ffffffff8028488d:       49 8d 04 00             lea    =
(%r8,%rax,1),%rax
       0        ffffffff80284891:       4c 8b 31                mov    =
(%rcx),%r14
    1143        ffffffff80284894:       48 c1 e8 0c             shr    =
$0xc,%rax
       0        ffffffff80284898:       48 6b c0 38             imul   =
$0x38,%rax,%rax
       0        ffffffff8028489c:       48 8d 1c 10             lea    =
(%rax,%rdx,1),%rbx
       0        ffffffff802848a0:       48 8b 03                mov    =
(%rbx),%rax
    3195        ffffffff802848a3:       25 00 40 00 00          and    =
$0x4000,%eax


=EF=BB=BF=EF=BB=BFThe =EF=BB=BFdisassembly of lots of functions are big=
, so the new kernertop truncates them by filtering some
instructions whose count are smaller than =EF=BB=BFcount_filter. It jus=
t shows the instructions whose count
are more than count_filter and 3 instructions ahead of the reported ins=
tructions. For example, before
printing
=EF=BB=BF3195 ffffffff802848a3: 25 00 40 00 00 and $0x4000,%eax
the new kerneltop prints other 3 instructions:
=EF=BB=BF0        ffffffff80284898:       48 6b c0 38             imul =
  $0x38,%rax,%rax
0        ffffffff8028489c:       48 8d 1c 10             lea    (%rax,%=
rdx,1),%rbx
0        ffffffff802848a0:       48 8b 03                mov    (%rbx),=
%rax

So users can go back quickly to find the instruction who really causes =
the event (not the reported
instruction by the performance counter).

Below is the patch against kernetop of Dec/23/2008 version.

yanmin

---

--- kerneltop.c.orig	2009-01-08 16:39:16.000000000 +0800
+++ kerneltop.c	2009-01-08 16:39:16.000000000 +0800
@@ -3,7 +3,7 @@
=20
    Build with:
=20
-     cc -O6 -Wall `pkg-config --cflags glib-2.0` -c -o kerneltop.o ker=
neltop.c
+     cc -O6 -Wall `pkg-config --cflags --libs glib-2.0` -o kerneltop k=
erneltop.c
=20
    Sample output:
=20
@@ -291,8 +291,6 @@ static void process_options(int argc, ch
 		else
 			event_count[counter] =3D 100000;
 	}
-	if (nr_counters =3D=3D 1)
-		count_filter =3D 0;
 }
=20
 static uint64_t			min_ip;
@@ -307,7 +305,7 @@ struct sym_entry {
=20
 #define MAX_SYMS		100000
=20
-static unsigned int sym_table_count;
+static int sym_table_count;
=20
 struct sym_entry		*sym_filter_entry;
=20
@@ -350,7 +348,7 @@ static struct sym_entry		tmp[MAX_SYMS];
=20
 static void print_sym_table(void)
 {
-	unsigned int i, printed;
+	int i, printed;
 	int counter;
=20
 	memcpy(tmp, sym_table, sizeof(sym_table[0])*sym_table_count);
@@ -494,7 +492,6 @@ static int read_symbol(FILE *in, struct=20
 			printf("symbol filter start: %016lx\n", filter_start);
 			printf("                end: %016lx\n", filter_end);
 			filter_end =3D filter_start =3D 0;
-			sym_filter_entry =3D NULL;
 			sym_filter =3D NULL;
 			sleep(1);
 		}
@@ -502,7 +499,6 @@ static int read_symbol(FILE *in, struct=20
 	if (filter_match =3D=3D 0 && sym_filter && !strcmp(s->sym, sym_filter=
)) {
 		filter_match =3D 1;
 		filter_start =3D s->addr;
-		sym_filter_entry =3D s;
 	}
=20
 	return 0;
@@ -538,6 +534,16 @@ static void parse_symbols(void)
 	last->sym =3D "<end>";
=20
 	qsort(sym_table, sym_table_count, sizeof(sym_table[0]), compare_addr)=
;
+
+	if (filter_end) {
+		int count;
+		for (count=3D0; count < sym_table_count; count ++) {
+			if (!strcmp(sym_table[count].sym, sym_filter)) {
+				sym_filter_entry =3D &sym_table[count];
+				break;
+			}
+		}
+	}
 }
=20
=20
@@ -617,11 +623,27 @@ static void lookup_sym_in_vmlinux(struct
 	}
 }
=20
+void show_lines(GList *item_queue, int item_queue_count)
+{
+	int i;
+	struct source_line *line;
+
+	for (i =3D 0; i < item_queue_count; i++) {
+		line =3D item_queue->data;
+		printf("%8li\t%s\n", line->count, line->line);
+		item_queue =3D g_list_next(item_queue);
+	}
+}
+
+#define TRACE_COUNT     3
+
 static void show_details(struct sym_entry *sym)
 {
 	struct source_line *line;
 	GList *item;
 	int displayed =3D 0;
+	GList *item_queue;
+	int item_queue_count =3D 0;
=20
 	if (!sym->source)
 		lookup_sym_in_vmlinux(sym);
@@ -633,16 +655,28 @@ static void show_details(struct sym_entr
 	item =3D sym->source;
 	while (item) {
 		line =3D item->data;
-		item =3D g_list_next(item);
 		if (displayed && strstr(line->line, ">:"))
 			break;
=20
-		printf("%8li\t%s\n", line->count, line->line);
+		if (!item_queue_count)
+			item_queue =3D item;
+		item_queue_count ++;
+
+		if (line->count >=3D count_filter) {
+			show_lines(item_queue, item_queue_count);
+			item_queue_count =3D 0;
+			item_queue =3D NULL;
+		} else if (item_queue_count > TRACE_COUNT) {
+			item_queue =3D g_list_next(item_queue);
+			item_queue_count --;
+		}
+
+		line->count =3D 0;
 		displayed++;
 		if (displayed > 300)
 			break;
+		item =3D g_list_next(item);
 	}
-	exit(0);
 }
=20
 /*
