From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 15/25] openrisc: Use Kbuild infrastructure for kvm_para.h
Date: Sat, 13 Oct 2012 08:32:36 +0200
Message-ID: <CACM3HyHnMHj=DB5FeLUfRsKT-a=KzcmdpSbudoLU7O48RzuPoA@mail.gmail.com>
References: <20121013022632.024527228@goodmis.org>
	<20121013022954.595178706@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121013022954.595178706@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On 13 October 2012 04:26, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Steven Rostedt <srostedt@redhat.com>
>
> All the headers but kvm_para.h use the Kbuild infrastructure to
> get to the asm-generic headers.
>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux@lists.openrisc.net
> Cc: Jonas Bonn <jonas@southpole.se>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Jonas Bonn <jonas@southpole.se>
