From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
Date: Mon, 28 Jul 2014 10:59:45 -0700
Message-ID: <53D68F91.4000106@zytor.com>
References: <cover.1405992946.git.luto@amacapital.net> <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com> <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
Sender: linux-security-module-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>, Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>
List-Id: linux-arch.vger.kernel.org

On 07/23/2014 12:20 PM, Andy Lutomirski wrote:
> 
> It looks like patches 1-4 have landed here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
> 
> hpa, what's the route forward for the x86 part?
> 

I guess I should discuss this with Kees to figure out what makes most
sense.  In the meantime, could you address Oleg's question?

	-hpa


