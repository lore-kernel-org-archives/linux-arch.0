From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v10 2/5] powerpc/vdso: Prepare for switching VDSO to
 generic C implementation.
Date: Wed, 5 Aug 2020 18:51:44 +0200
Message-ID: <7d409421-6396-8eba-8250-b6c9ff8232d9@csgroup.eu>
References: <cover.1596611196.git.christophe.leroy@csgroup.eu>
 <348528c33cd4007f3fee7fe643ef160843d09a6c.1596611196.git.christophe.leroy@csgroup.eu>
 <20200805140307.GO6753@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200805140307.GO6753@gate.crashing.org>
Content-Language: fr
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: nathanl@linux.ibm.com, linux-arch@vger.kernel.org, vincenzo.frascino@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, luto@kernel.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Hi Again,

Le 05/08/2020 à 16:03, Segher Boessenkool a écrit :
> Hi!
> 
> On Wed, Aug 05, 2020 at 07:09:23AM +0000, Christophe Leroy wrote:
>> +/*
>> + * The macros sets two stack frames, one for the caller and one for the callee
>> + * because there are no requirement for the caller to set a stack frame when
>> + * calling VDSO so it may have omitted to set one, especially on PPC64
>> + */
> 
> If the caller follows the ABI, there always is a stack frame.  So what
> is going on?

Looks like it is not the case. See discussion at 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/2a67c333893454868bbfda773ba4b01c20272a5d.1588079622.git.christophe.leroy@c-s.fr/

Seems like GCC uses the redzone and doesn't set a stack frame. I guess 
it doesn't know that the inline assembly contains a function call so it 
doesn't set the frame.


Christophe
