From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 04/44] trace/ring_buffer: handle 64bit aligned structs
Date: Mon, 10 Dec 2012 10:27:08 +0000
Message-ID: <50C5B8FC.3080003@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>  <1354723742-6195-5-git-send-email-james.hogan@imgtec.com> <1354929851.17101.105.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354929851.17101.105.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

On 08/12/12 01:24, Steven Rostedt wrote:
> On Wed, 2012-12-05 at 16:08 +0000, James Hogan wrote:
>> Some 32 bit architectures have 64 bit struct alignment (for example
>> Meta which has 64 bit read/write instructions). These require 8 byte
>> alignment of event data too, so use CONFIG_HAVE_64BIT_ALIGNED_STRUCT
>> instead of CONFIG_64BIT to decide alignment, and align
>> buffer_data_page::data accordingly.
>>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> 
> Acked-by: Steven Rostedt <rostedt@goodmis.org>

Thanks Steven

Cheers
James
