From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Date: Wed, 19 Feb 2020 22:33:37 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F57E302@ORSMSX115.amr.corp.intel.com>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.488895196@infradead.org> <20200219171309.GC32346@zn.tnic>
 <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
 <20200219173358.GP18400@hirez.programming.kicks-ass.net>
 <CALCETrVdNCRoToO2-mxhPxO2zaRU6urTffBn7iSTgHaGpB523Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:36563 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbgBSWdj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 17:33:39 -0500
In-Reply-To: <CALCETrVdNCRoToO2-mxhPxO2zaRU6urTffBn7iSTgHaGpB523Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, Greg KH <gregkh@linuxfoundation.org>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>, Thomas Gleixner <tglx@linutronix.de>, "paulmck@kernel.org" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>

PiBPbmUgYmlnIHF1ZXN0aW9uIGhlcmU6IGFyZSBtZW1vcnkgZmFpbHVyZSAjTUMgZXhjZXB0aW9u
cyBzeW5jaHJvbm91cw0KPiBvciBjYW4gdGhleSBiZSBkZWxheWVkPyAgIElmIHdlIGdldCBhIG1l
bW9yeSBmYWlsdXJlLCBpcyBpdCBwb3NzaWJsZQ0KPiB0aGF0IHRoZSAjTUMgaGl0cyBzb21lIHJh
bmRvbSBjb250ZXh0IGFuZCBub3QgdGhlIGFjdHVhbCBjb250ZXh0IHdoZXJlDQo+IHRoZSBlcnJv
ciBvY2N1cnJlZD8NCg0KVGhlcmUgYXJlIGEgZmV3IGNhc2VzOg0KMSkgU1JBTyAoU29mdHdhcmUg
cmVjb3ZlcmFibGUgYWN0aW9uIG9wdGlvbmFsKSBbUGF0cm9sIHNjcnViIG9yIEwzIGNhY2hlIGV2
aWN0aW9uXQ0KVGhlc2UgYXJlbid0IHN5bmNocm9ub3VzIHdpdGggYW55IGNvcmUgZXhlY3V0aW9u
LiBVc2luZyBtYWNoaW5lIGNoZWNrIHRvIHNpZ25hbA0Kd2FzIHByb2JhYmx5IGEgbWlzdGFrZSAt
IGNvbXBvdW5kZWQgYnkgaXQgYmVpbmcgYnJvYWRjYXN0IDotKCAgQ291bGQgcGljayBhbnkgQ1BV
DQp0byBoYW5kbGUgKGFjdHVhbGx5IGNob29zZSB0aGUgZmlyc3QgdG8gYXJyaXZlIGluIGRvX21h
Y2hpbmVfY2hlY2soKSkuIFRoYXQgZ3V5IHNob3VsZA0KYXJyYW5nZSB0byBzb2Z0IG9mZmxpbmUg
dGhlIGFmZmVjdGVkIHBhZ2UuIEV2ZXJ5IENQVSBjYW4gcmV0dXJuIHRvIHdoYXQgdGhleSB3ZXJl
IGRvaW5nDQpiZWZvcmUuDQoNCjIpIFNSQVIgKFNvZnR3YXJlIHJlY292ZXJhYmxlIGFjdGlvbiBy
ZXF1aXJlZCkNClRoZXNlIGFyZSBzeW5jaHJvbm91cy4gU3RhcnRpbmcgd2l0aCBTa3lsYWtlIHRo
ZXkgbWF5IGJlIHNpZ25hbGVkIGp1c3QgdG8gdGhlIHRocmVhZA0KdGhhdCBoaXQgdGhlIHBvaXNv
bi4gRWFybGllciBnZW5lcmF0aW9ucyBicm9hZGNhc3QuDQoJMmEpIEhpdCBpbiByaW5nMyBjb2Rl
IC4uLiB3ZSB3YW50IHRvIG9mZmxpbmUgdGhlIHBhZ2UgYW5kIFNJR0JVUyB0aGUgdGFzayhzKQ0K
CTJiKSBNZW1jcHlfbWNzYWZlKCkgLi4uIGtlcm5lbCBoYXMgYSByZWNvdmVyeSBwYXRoLiAiUmV0
dXJuIiB0byB0aGUgcmVjb3ZlcnkgY29kZSBpbnN0ZWFkIG9mIHRvIHRoZSBvcmlnaW5hbCBSSVAu
DQoJMmMpIGNvcHlfZnJvbV91c2VyIC4uLiBub3QgaW1wbGVtZW50ZWQgeWV0LiBXZSBhcmUgaW4g
a2VybmVsLCBidXQgd291bGQgbGlrZSB0byB0cmVhdCB0aGlzIGxpa2UgY2FzZSAyYQ0KDQozKSBG
YXRhbA0KQWx3YXlzIGJyb2FkY2FzdC4gU29tZSBiYW5rIGhhcyBNQ2lfU1RBVFVTLlBDQz09MS4g
U3lzdGVtIG11c3QgYmUgc2h1dGRvd24uDQoNCi1Ub255DQo=
